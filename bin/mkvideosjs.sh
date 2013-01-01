#!/bin/sh

echo "var _videoDB = {"

for file in $@; do 
    date=$(echo $file|cut -d/ -f2,3,4)
    echo "'$date': {file:'../$file'},"
done

echo "};"
