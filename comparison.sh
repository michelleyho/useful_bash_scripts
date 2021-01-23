#!/bin/bash

a=1
b=2
c=$(( $a + $b ))
[ $a -gt $b ]
echo $?
echo $c

str1="apples"
str2="oranges"

[ $str1 = $str2 ]
echo $?


string_a="UNIX"
string_b="GNU"

echo -n "Are $string_a and $string_b strings equal?"
[ $string_a = $string_b ]
echo $?

num_a=100
num_b=100

echo -n "Is $num_a equal to $num_b ?" 
[ $num_a -eq $num_b ]
echo $?

num1=100
num2=200

if [ $num1 -lt $num2 ]; then
  echo "$num1 is less than $num2"
else
  echo "$num2 is less than $num1"
fi
