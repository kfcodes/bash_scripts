#!/bin/bash
echo give a brightness between 1 and 10:
read brightness
xrandr --output DVI-D-0 --brightness .$brightness
