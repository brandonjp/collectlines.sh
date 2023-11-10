#!/bin/bash

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

#Loop over each text file
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
