#! /bin/bash

# Take a photo every time someone logs into the laptop
# http://ubuntuforums.org/archive/index.php/t-1509424.html

EMAIL='[your@email.address]'
TIMESTAMP=$(date +%R.%S-%B-%d)

cd $HOME/Pictures/Webcam/
streamer -t 10 -r 1 -s 640x480 -o cap00.jpeg > /dev/null

cp cap03.jpeg $TIMESTAMP-1.jpg
cp cap04.jpeg $TIMESTAMP-2.jpg
cp cap05.jpeg $TIMESTAMP-3.jpg
cp cap06.jpeg $TIMESTAMP-4.jpg
cp cap07.jpeg $TIMESTAMP-5.jpg
rm cap*

(for i in *.jpg
do 
uuencode $i $(basename $i) 
done
) | mailx -s "Security Alert- $TIMESTAMP" $EMAIL

mv $HOME/Pictures/Webcam/*.jpg $HOME/Pictures/Webcam/old/

ffmpeg -f video4linux2 -s vga -i /dev/video0 -vframes 3 $HOME/vid-test.%01d.jpg
