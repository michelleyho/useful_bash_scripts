#!/bin/bash


function total_files {
  find $1 -type f 2> /dev/null | wc -l
}

function total_directories {
  find $1 -type d 2> /dev/null | wc -l
}

function total_archived_directories {
  tar -tzf $1 | grep /$ | wc -l
}

function total_archived_files {
  tar -tzf $1 | grep -v /$ | wc -l
}

function backup {
  
  user=$(whoami)

  # -z -> checks if positional argumen $1 contains any value
  # Returns true if the length of string in $1 is zero, else false.
  # basically, if $1 argument, set a default directory to backup
  if [ -z $1 ]; then
    input=/home/$user/workspace/homichel/
    output=/tmp/${user}_homichel_$(date +%Y-%m-%d_%H%M%s).tar.gz
  else
    # -d --> checks if directory exists. the ! negates.  
    # if director not exist, do something
    if [ ! -d "/home/$user/workspace/homichel/$1" ]; then
      echo "Requested $1 in $user/workspace/homichel directory doesn't exist"
      exit 1 #exit with error to indicate there's an issue
    fi
    input=/home/$user/workspace/homichel/$1
    output=/tmp/${user}_homichel_$1_$(date +%Y-%m-%d_%H%M%s).tar.gz
  fi
  
  
  
  
  tar -czf $output $input
  
  src_files=$( total_files $input )
  src_directories=$( total_directories $input )
  
  arch_files=$( total_archived_files $output)
  arch_directories=$( total_archived_directories $output )
  
  echo "######## $1 #################"  
  echo "Files to be included: $src_files"
  echo "Directories to be included: $src_directories"
  echo "Files archived: $arch_files"
  echo "Directories archived: $arch_directories"
  
  if [ $src_files -eq $arch_files ]; then
    echo "Backup for $input completed!"
    echo "Details about the output backup file:"
    ls -l $output
  else
    echo "Backup of $input failed!"
  fi
  
}


for directory in $*; do
  backup $directory
  let all=$all+$arch_files+$arch_directories
done;

echo "TOTAL FILES AND DIRECTORIES: $all"
