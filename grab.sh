#!/bin/sh

base=$(pwd)/images
dir=${base}/`date +%Y`/`date +%m`/`date +%d`
filename=${dir}/`date +%Y%m%d-%H%M%S`.jpg

mkdir -p $dir

/usr/bin/fswebcam --quiet --resolution 640x480 $filename

echo grab.sh: output image to $filename
