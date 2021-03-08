#!/bin/bash

input=$1
# Declare associative array
declare -A word_freq

n=1
while IFS= read -r line
do 
    echo "Line #${n}" "$line"
    n=$((n+1))
    
    for word in $line; do
        (( word_freq["\${word}"]++ ))
    done
done < $input

for word in "${!word_freq[@]}"; do
    echo "$word - ${word_freq[$word]}";
done | sort -rn -k2 # sorts in reverse order, using the second field as a numeric value
