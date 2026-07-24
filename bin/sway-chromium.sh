export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-1
chromium \
  --ozone-platform=wayland \
  --enable-features=WebRTCPipeWireCapturer \
  --disable-gpu \
  --disable-gpu-memory-buffer-video-frames \
  --disable-gpu-compositing \
  --disable-gpu-rasterization \
  --disable-software-rasterizer=false \
  --num-raster-threads=1 \
  --cast-initial-offline-id=1 \
  --use-fake-device-for-media-stream \
  --in-process-gpu \
  --force-use-vulkan=false
  # --enable-logging=stderr --v=1
