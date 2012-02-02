#!/bin/bash
# originally from http://www.scibuff.com/2009/05/14/download-apod-and-set-it-as-the-wallpaper-batch-script/
# fixed 21-May-2011

APOD_DIR=/home/$USER/apod

test=$(ps -u $USER | grep sshd | wc -l) #test if you are using ssh or logged in physically
#test=$( /usr/bin/w | /bin/awk  ' /'$USER'/  {print " " $3} ' | /bin/fgrep ' -'| /usr/bin/wc -l )
if [ "$test" == "0" ]
then
#sleep 20
if [ "$1" = "" ];
then
    date=$(date -d'5 hours ago' +'%y%m%d')
else
    date=$1
fi

test2=$(ls $APOD_DIR | fgrep "apod_$date." | wc -l)
if [ "$test2" == "0" ]
then
    # exit
    # rm $APOD_DIR/apod_*

ext=$(curl --silent http://apod.nasa.gov/apod/ap$date.html | awk '/[Ii][Mm][Gg] [Ss][Rr][Cc]/' | sed -e 's/<IMG SRC=\"/http:\/\/apod.nasa.gov\/apod\//g' | awk ' {split($0,arr,"\"") ; print $1}' | awk ' {print(substr ($1,length($1)-3,3)) }')
src=$(curl --silent http://apod.nasa.gov/apod/ap$date.html | awk '/[Ii][Mm][Gg] [Ss][Rr][Cc]/' | sed -e 's/<IMG SRC=\"/http:\/\/apod.nasa.gov\/apod\//g' | awk ' {split($0,arr,"\"") ; print $1}' | awk ' {print(substr ($1,1,length($1)-5))}' )

img=$(echo $src.$ext)

dest=$APOD_DIR/apod_$date.$ext

curl --silent $img > $dest

kde=$(ps -A | grep 'kde'| wc -l)
gnome=$(ps -A | grep 'gnome' | wc -l)
if [ "$kde" != "0" ]
then
    dcop kdesktop KBackgroundIface 'setWallpaper(QString,int)' $APOD_DIR/apod_$date.$ext 6 
    echo "background image updated"
fi

if [ "$gnome" != "0" ]
then
    gconftool-2 --type=string --set /desktop/gnome/background/picture_options stretched
    gconftool-2 --type=string --set /desktop/gnome/background/picture_filename  $APOD_DIR/apod_$date.$ext
    echo "background image updated"
fi
 #echo -e '<HTML>\n <HEAD><TITLE>APOD</TITLE></HEAD>\n <BODY>' > $HOME/apod/apod_description.html
 #curl --silent http://apod.nasa.gov/apod/ap$date.html | sed -n '/<b> Explanation:/,/<p> <center>/ p' | sed -n '2,$ p' | sed -e '$d' | sed -e '$d' >>  $HOME/Desktop/apod_description.html
 #echo -e '</BODY> </HTML>' >>  $HOME/apod/apod_description.html
fi
fi
