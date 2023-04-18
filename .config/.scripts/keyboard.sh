#!/bin/sh

# change layout to uk (great britan")
setxkbmap -layout gb

# change caps to escape
xmodmap -e 'clear Lock'
xmodmap -e 'keycode 0x42=Escape'

# change keyboard rate
xset r rate 300 50
