#!/bin/bash
if [ "$#" -ne "3" ] 
then
  echo "ERROR: Incorrect number of parameters. Please enter 3 parameters."
else 
  if [ "$1" -gt "$2" ]
  then
    if [ "$1" -gt "$3" ]
    then 
      echo "Largest number: $1"
    elif [ "$1" -lt "$3" ]
    then
      echo "Largest number: $3"
    fi

  elif [ "$2" -gt "$1" ]
  then
    if [ "$2" -gt "$3" ]
    then 
      echo "Largest number: $2"
    elif [ "$2" -lt "$3" ]
    then
      echo "Largest number: $3"
    fi

  elif [ "$3" -gt "$1" ] 
  then
    if [ "$3" -gt "$2" ] 
    then
      echo "Largest number: $3"
    elif [ "$3" -lt "$2" ]
    then 
      echo "Largest number: $2"
    fi   

  else 
    echo "All numbers are equal. No largest number."

  fi
fi
