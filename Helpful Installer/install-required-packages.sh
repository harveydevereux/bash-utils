#!/bin/bash

#### can use namefile  or manual as below ####
# PYTHON_PACKAGES=("pyAudioAnalysis"
#                  "scipy"
#                  "midiutil"
#                  "matplotlib"
#                  "numpy"
#                  "pyaudio")
#
# SYSTEM_PACKAGES=("portaudio19-dev")

while getopts ":hf" option; do
  case $option in
    h) echo "usage: $0 [-h] [-f namefile]"; exit ;;
    f) source $2 ;;
    ?) echo "error: option -$OPTARG is not implemented"; exit ;;
  esac
done

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
#escape shortcuts
TICK="\e[32m \u2714"
CROSS="\e[31m \u274c"
UNDERLINE="\e[4m"
# return to normal
DEFAULT="\e[39m\e[0m"

echo -e "REASON FOR INSTALLER"

# gets user concent for the installs
install_concent(){
  echo "${BOLD}Install pakage: "$1" now? [y/n]${NORMAL}"
  read response
  if [ "$response" == "y" ]
    then return 0
  else
    return 1
  fi
}

# python checker change to 2 or 3...
if ! [[ $(python --version 2>&1) =~ 2\.7 ]]
    then echo "${BOLD}You must use python 2 (>=2.7) for this project${NORMAL}"
fi

# sudo check
if [ "$EUID" -ne 0 ]
  then echo "${BOLD}This is an install script please run as root${NORMAL}"
  exit
fi

echo -e "${BOLD}Checking installed system packages...${NORMAL}\n"

if [ ${#SYSTEM_PACKAGES[@]} == 0 ]
  then echo "${BOLD}Nothing to do here...${NORMAL}"
fi

for pkg in "${SYSTEM_PACKAGES[@]}"; do
  dpkg-query -l $pkg 2> /dev/null
  if [ $? -eq 1 ];
    then
      if install_concent $pkg;
        then apt-get install $pkg
        echo -e "${BOLD} $pkg installed${NORMAL}"$TICK$DEFAULT
      else
        echo -e "${BOLD}system package: $pkg not installed${NORMAL}"$CROSS$DEFAULT
      fi
  else
    echo -e "${BOLD}$pkg already installed${NORMAL}"$TICK$DEFAULT
  fi
done
echo -e "\n${BOLD}Checking python 2 packages...\n${NORMAL}"

if [ ${#PYTHON_PACKAGES[@]} == 0 ]
  then echo "${BOLD}Nothing to do here...${NORMAL}"
fi
# check if the python packages are installed
for pkg in "${PYTHON_PACKAGES[@]}"; do
  if python -c "import $pkg";
    then echo -e "${BOLD}"$pkg" already installed${NORMAL}"$TICK$DEFAULT
  else
    if install_concent $pkg;
      then pip install $pkg
      echo -e "${BOLD}"$pkg" installed${NORMAL}"$TICK$DEFAULT
    else
      echo -e "${BOLD}python package: $pkg not installed${NORMAL}"$CROSS$DEFAULT
    fi
  fi
done

echo -e "\n${BOLD}Good to go!${NORMAL}"

exit
