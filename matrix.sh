#!/bin/bash

source text_shortcuts.sh
COLS=$(tput cols)
LINE="${GREEN}"
while true; do
  # time milliseconds
  START=$(($(date +%s%N)/1000000))
  COUNTER=0
  until [ $COUNTER == $COLS ]; do
    LINE=$LINE"${GREEN}"
    let COUNTER+=1
    if [ $(($RANDOM % 4)) == 0 ]
      then LINE=$LINE"\t"
      continue
    fi
    if [ $(($RANDOM % 4)) == 0 ]
      then LINE=$LINE"${DEFAULT}"
    fi
    if [ $(($RANDOM % 2)) == 0 ]
      then LINE=$LINE" "$(printf \\$(printf '%03o' $((97+$(($RANDOM % 26))))))
      continue
    else
      LINE=$LINE" "$(printf \\$(printf '%03o' $((65+$(($RANDOM % 26))))))
      continue
    fi
  done
  echo -e $LINE
  while [ $(($(($(date +%s%N)/1000000)) - $START)) -lt 250 ]; do
    continue
  done
done
