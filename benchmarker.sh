#!/bin/bash
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

N=1

while getopts ":hn" option; do
  case $option in
    h) echo "usage: $0 [-h] [-n integer]"; exit ;;
    n) N=$2 ;;
    ?) echo "error: option -$OPTARG is not implemented"; exit ;;
  esac
done

if [ $N -eq $N 2> /dev/null ]==1;
then
  echo "Need and integer argument"
  exit
fi

declare -a MEMORY_A
declare -a MEMORY_B
declare -a TIMES
# the parameter
declare -a NTREES

COUNT=0
while [ $COUNT -lt $N ]; do
  COUNT=$(($COUNT+1))
  NTREES[$COUNT]=$((2**$COUNT))
  TIC=$(date +%s.%N)
  MEMORY_A[$COUNT]=$(free -m | awk 'NR==2{printf "%s \n", $3,$2,$3*100/$2}')
  # put in the command to time
  #./mondrianforest_demo.py --dataset letter --n_mondrians ${NTREES[COUNT]} --budget -1 --normalize_features 1 --optype class
  TOC=$(date +%s.%N)
  MEMORY_B[$COUNT]=$(free -m | awk 'NR==2{printf "%s \n", $3,$2,$3*100/$2}')
  TIMES[$COUNT]=$(echo $TOC-$TIC | bc)
  echo -e "${BOLD}Trained with ${NTREES[COUNT]} Mondrian trees. Time: ${TIMES[COUNT]}${NORMAL}"
done

touch output.txt
echo "${NTREES[@]}
${TIMES[@]}
${MEMORY_A[@]}
${MEMORY_B[@]}" > output.txt

echo -e "${BOLD}Output is\nNTREEs\nTIMES\nMEMORY_A\nMEMORY_B\n${NORMAL}"
