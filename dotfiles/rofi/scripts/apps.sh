#!/usr/bin/env bash

if [[ -z "$@" ]]; then
  echo "Firefox"
  echo "Spotify"
else 
  case $1 in
    "Firefox") firefox;;
    "Spotify") spotify;;
  esac
fi
