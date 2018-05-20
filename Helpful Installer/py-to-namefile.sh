#!/bin/bash
# scrapes a python file for imports
# add imported package names to an array
# and outputs a namefile for use with
# install-required-packages.sh
OUT="PYTHON_PACKAGES=("
RECORD=false
# read the file given as argument
while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
    #find the imports
    for WORD in $LINE; do
        if [ $RECORD == true ]
            then OUT=$OUT" "$WORD" "
            RECORD=false
        fi
        if [ $WORD == "import" ]
            then RECORD=true
        fi
    done
done < "$1"
OUT=$OUT")"
touch $1".namefile"
echo $OUT > $1".namefile"
exit
