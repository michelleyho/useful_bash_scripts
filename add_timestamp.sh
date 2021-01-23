#!/bin/bash

current_date=$(date +"%m_%d_%y")
timestamped_files="files_${current_date}"

mkdir $timestamped_files

all_files=`ls *.sh `

for file in $all_files; do
  name="${file%.*}"
  ext="${file##*.}"
  cp -v $file $timestamped_files/$name.$current_date.$ext
done;
