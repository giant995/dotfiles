#!/bin/bash
if xrandr --query | grep 'HDMI-2 connected'; then
  xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
  echo 'test'
fi

