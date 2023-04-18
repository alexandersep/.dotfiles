#!/bin/bash

start_dir=`pwd`
cd /home/sasha/Documents/Notes/Year3/Sem1/Samples/
for file in *.md; do
    #date=`grep "> Date: " $file | awk '{print $3}'`
    #echo "$date $file"
    echo "`grep -E "> Date: [0-3][0-9]-[0-1][0-9]-[0-9]{2}" $file` $file"
done | \
sort -n -t "-" -k3 -k2 -k1 | \
awk '{print $5}'
#tr '\ ' '\n'
cd $start_dir
