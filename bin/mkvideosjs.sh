#!/bin/sh

echo "var _videoDB = {"

for file in $@; do 
    date=$(echo $file|cut -d/ -f2,3,4)
    duration=$(ffmpeg -i $file 2>&1 | awk '/Duration/ {split($2, A, "."); print A[1]}')
    echo -n "  '$date': {"
    echo -n " file:'../$file'"
    echo -n ", duration:'$duration'"
    echo " },"
done

echo "};"
