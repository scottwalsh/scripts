#!/usr/bin/env bash

# crontab
# 0 */6 * * *

#http://www.reddit.com/r/linux/comments/dz7db/use_an_accurate_satellite_view_of_the_earth_as/?utm_source=twitterfeed&utm_medium=statusnet

gconftool-2 --type string --set /desktop/gnome/background/picture_options "none"
gconftool-2 --type string --set /desktop/gnome/background/picture_filename ""
wget http://static.die.net/earth/mercator/1600.jpg -O $HOME/.cache/wallpaper.jpg --user-agent="Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10"
gconftool-2 --type string --set /desktop/gnome/background/picture_filename $HOME/.cache/wallpaper.jpg
gconftool-2 --type string --set /desktop/gnome/background/picture_options "scaled"
