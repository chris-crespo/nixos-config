/nix/store/wbqwrp6gpf31acmdchik5lsj8zdw2z24-dbus-1.14.10/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP \
  && systemctl --user stop hyprland-session.target \
  && systemctl --user start hyprland-session.target
