#!/usr/bin/env bash

if [[ -z "$@" ]]; then
  echo "Firefox"
else 
  case $1 in
    "Firefox") firefox;;
  esac
fi
