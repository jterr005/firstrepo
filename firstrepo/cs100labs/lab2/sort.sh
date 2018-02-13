#!/bin/bash

ARRAY[$#]
for i in 231 93 12 22 6
do
  ARRAY[i]=$i
 #echo "Current: ${ARRAY[i]}"
done

i=1
while [$i -lt ${ARRAY[@]}] 
do
  j=$i
  while [ $j -gt 0 ] && [ ARRAY[$j-1 ] -gt ARRAY[$j]] 
  do 
    
