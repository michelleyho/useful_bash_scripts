#!/bin/bash

function check_file {

  if cmp --silent -- "$1" "$2"; then
    echo "$1 and $2 contents are identical"
  else
    echo "$1 and $2 differ"
  fi

}

current_date=$(date +"%m_%d_%y")
timestamped_files="files_${current_date}"

mkdir $timestamped_files

all_files=`ls *.sh `

for file in $all_files; do
  name="${file%.*}"
  ext="${file##*.}"
  new_file=$timestamped_files/$name.$current_date.$ext
  cp -v $file $new_file
  check_file $file $new_file	
done;
