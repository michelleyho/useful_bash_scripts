#!/bin/bash

function user_details {

  echo "User: $(whoami)"
  echo "Home directory: $HOME"

}

function total_files {
  
  find $1 -type f 2> /dev/null | wc -l

}

function total_directories {

  find $1 -type d 2> /dev/null | wc -l
}

home_directory=$HOME

user_details
echo -n "Total files:"
total_files $home_directory
echo -n "Total directories:"
total_directories $home_directory
