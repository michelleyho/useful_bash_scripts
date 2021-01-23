#!/bin/bash

for f in $( ls $1); do
  char=$( echo -n $f | wc -m )
  echo "$f has $char"
done

counter=0
while [ $counter -lt 3 ]; do
  echo $counter
  let counter+=1
done

counter=6
until [ $counter -lt 3 ]; do
  let counter-=1
  echo $counter
done
