#!/bin/sh


## Directory containing required file
FROM="<source directory>"

## Directory where the files will be copied
TO="<destination directory>"

## we are copying verilog files so .v is used here. Change the extension as per your requirement

for file in `find $FROM -type f -name "*.v" | awk -F "*.v" '{print $NF}'`
do
    for dir in `find $FROM -type d`
    do
         find $dir -type f -samefile $file | awk '{print "ls -ltrh" " " $0}'
    done | sh | sed -n '$p'
done | awk '{print "cp -rvfp" " " $NF " " "$TO"}' | sh
