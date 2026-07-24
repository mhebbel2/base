#!/bin/bash

# Force headless backend and disable XWayland
export WLR_BACKENDS=headless
export WLR_LIBINPUT_NO_DEVICES=1
export WLR_NO_HARDWARE_CURSORS=1
export XWAYLAND_DISABLE=1
export WAYLAND_DISPLAY=wayland-1

# Ensure XDG_RUNTIME_DIR is set
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

# Start sway and output to a log for debugging
sway > /tmp/sway.log 2>&1 &
SWAY_PID=$!

# Inside your sway script, before starting wayvnc/chromium:
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
systemctl --user stop pipewire xdg-desktop-portal-wlr
systemctl --user start pipewire xdg-desktop-portal-wlr

# Wait for the socket
SOCKET="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
for i in {1..10}; do
    if [ -S "$SOCKET" ]; then
        break
    fi
    sleep 0.5
done

if [ ! -S "$SOCKET" ]; then
    echo "Sway failed to create socket at $SOCKET"
    exit 1
fi

# Now that the socket exists, wayvnc can connect
wayvnc 0.0.0.0 5900 --output=HEADLESS-1 >& /tmp/vnc.log &

