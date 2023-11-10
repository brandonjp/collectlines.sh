#!/bin/bash

# The first four arguments are treated as single values that control the operation of the script.
DIRECTORY=$1 # The directory to search for files
FILE_EXTENSION=$2 # The file extension to look for (without the dot)
OUTPUT_FILE=$3 # The name of the file to write the output to
LINE_NUMBERS=("${@:4}") # All remaining arguments are treated as line numbers to extract

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory $DIRECTORY does not exist"
  exit 1
fi

# Create or truncate the output file
# The ":" command is a shell builtin that does nothing, but because of the redirection operator,
# this line effectively creates the OUTPUT_FILE if it does not exist and empties it if it does.
: > "$OUTPUT_FILE"

# Loop over each file in the directory with the specified extension
for file in "$DIRECTORY"/*."$FILE_EXTENSION"; do
  # The -e test returns true if the file exists
  if [ -e "$file" ]; then
    # Echo the file name to the output file
    echo "# $file" >> "$OUTPUT_FILE"
    # Loop over each line number specified
    for line in "${LINE_NUMBERS[@]}"; do
      # The sed -n "${line}p" command prints the line number (contained in the ${line} variable)
      # from the file, appending it to the output file.
      sed -n "${line}p" "$file" >> "$OUTPUT_FILE"
    done
    # Append a blank line for readability
    echo "" >> "$OUTPUT_FILE"
  fi
done
