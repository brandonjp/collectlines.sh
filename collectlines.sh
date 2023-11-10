#!/bin/bash

# Script Usage:
# Regular Mode: ./script.sh /path/to/directory txt output.txt 1 3 5
# Random Mode:  ./script.sh -r 5 /path/to/directory txt output.txt 1 3 5

# In regular mode, the script loops over all text files in the directory, 
# and for each file, extracts the requested line numbers and appends them to the output file.

# In random mode (enabled with the -r flag), the script first randomly shuffles 
# the files in the directory, then extracts line numbers from the first N files, where N is provided as the argument to the -r flag.

# The arguments to the script are as follows:
# -r: (optional) Enable random mode. The next argument should be the number of files to read.
# /path/to/directory: The directory to look for files to read.
# txt: The file extension of the files to read.
# output.txt: The file to write the output to.
# 1 3 5: A list of line numbers to extract from each file. Can be any number of line numbers.

# Default mode is not random
RANDOM_MODE=0

# Parse arguments
while getopts ":r:" opt; do
  case ${opt} in
    r)
      RANDOM_MODE=1
      MAX_FILES=$OPTARG
      ;;
    \?)
      echo "Invalid option: $OPTARG" 1>&2
      exit 1
      ;;
    :)
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

#Assign arguments to variables
DIRECTORY=$1
FILE_EXTENSION=$2
OUTPUT_FILE=$3
LINE_NUMBERS=("${@:4}")

#Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory $DIRECTORY does not exist"
  exit 1
fi

#Create or truncate output file
: > "$OUTPUT_FILE"

#If random mode is enabled
if [ $RANDOM_MODE -eq 1 ]; then
  #Put all files into an array
  FILES=("$DIRECTORY"/*."$FILE_EXTENSION")

  #Randomly shuffle the files array
  FILES=($(shuf -e "${FILES[@]}"))

  #Loop over each text file up to the max number of files
  for file in "${FILES[@]:0:$MAX_FILES}"
  do
    if [ -e "$file" ]; then
      echo "# $file" >> "$OUTPUT_FILE"
      #Loop over each line number
      for line in "${LINE_NUMBERS[@]}"; do
        #Print the specified line number
        sed -n "${line}p" "$file" >> "$OUTPUT_FILE"
      done
      echo "" >> "$OUTPUT_FILE"
    fi
  done
else
  # Regular mode, loop over each text file
  for file in "$DIRECTORY"/*."$FILE_EXTENSION"; do
    if [ -e "$file" ]; then
      echo "# $file" >> "$OUTPUT_FILE"
      #Loop over each line number
      for line in "${LINE_NUMBERS[@]}"; do
        #Print the specified line number
        sed -n "${line}p" "$file" >> "$OUTPUT_FILE"
      done
      echo "" >> "$OUTPUT_FILE"
    fi
  done
fi
