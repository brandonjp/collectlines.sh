# collectlines.sh
bash script to collect line numbers from files in a folder

## Usage
Given a folder full of text files...
`./collectlines.sh /path/to/directory txt output.txt 1 3 5`
This would grab lines 1, 3, and 5 from all .txt files in the specified directory and append the results to output.txt. The output file is created if it does not exist, or it is emptied if it does. The appended text includes the file name followed by the requested lines for that file.


