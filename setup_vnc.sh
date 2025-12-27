VNC="tigervnc-standalone-server tigervnc-common tigervnc-tools dbus-x11 xfce4 xfce4-terminal chromium "
apt-get -y -qq update
apt-get -y -qq install $VNC >/dev/null
#
# --- vnc
cp /root/base/vncserver.service /etc/systemd/system/
systemctl enable vncserver.service
systemctl start vncserver.service

