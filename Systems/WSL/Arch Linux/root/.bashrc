export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8

run_desktop() {
    Xwayland :3 -geometry 1920x1080 -fullscreen -glamor gl &
    sleep 1
    WAYLAND_DISPLAY= DISPLAY=:3 dbus-launch startxfce4
}

alias desktop="run_desktop"

if ! pgrep -x "Xwayland" > /dev/null; then
    run_desktop > /dev/null 2>&1 &
    disown
fi
