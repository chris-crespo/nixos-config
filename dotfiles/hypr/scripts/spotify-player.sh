#!/usr/bin/env bash

play/pause() {
  echo ":: Play/Pause"
  dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.PlayPause
}

previous() {
  echo ":: Previous"
  dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Previous
}

next() {
  echo ":: Next"
  dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Next
}

usage() {
  cat <<EOF
usage: spotify-player <command>

commands:
  play/pause      Toggle the player
  previous        Play the previous song
  next            Play the next song
EOF
}

case "$1" in
  "play/pause") play/pause;;
  "previous") previous;;
  "next") next;;
  *) usage;;
esac

