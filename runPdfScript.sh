#!/bin/bash
#The user is required to open the pdf file first on any browser
#Then run this script as many times as they want for every change
pdflatex *.tex # "compile" latex

PACKAGE="xdotool"
BROWSER=$1

#check if the package is found (0 is true)
found=1
(dpkg -s $PACKAGE | grep -q "ok installed") && found=0

if [ $found -eq 0 ]
then
    echo "Found the package $PACKAGE"
    [ -z "${BROWSER}" ] && BROWSER=brave-browser
    echo "Refreshing using $BROWSER"

    focused_window_id=$(xdotool getwindowfocus)                             # remember current window
    xdotool search --onlyvisible --class $BROWSER windowfocus key 'ctrl+r'  # send keystroke to refresh
    xdotool windowactivate --sync $focused_window_id                        # switch window, sync to "wait"
else
    echo "Installing $PACKAGE in 5 seconds..."
    sleep 5
    sudo apt install xdotool
fi
