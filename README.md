# collectlines.sh
bash script to collect line numbers from files in a folder

## Usage

### Regular Mode: 
`./script.sh /path/to/directory txt output.txt 1 3 5`

### Random Mode:  
`./script.sh -r 5 /path/to/directory txt output.txt 1 3 5`

In **regular mode**, the script loops over all text files in the directory, and for each file, extracts the requested line numbers and appends them to the output file.

In **random mode** (enabled with the -r flag), the script first randomly shuffles  the files in the directory, then extracts line numbers from the first N files, where N is provided as the argument to the -r flag.

### Arguments 
The arguments to the script are as follows:

* `-r`: (optional) Enable random mode. The next argument should be the number of files to read.
* `/path/to/directory`: The directory to look for files to read.
* `txt`: The file extension of the files to read.
* `output.txt`: The file to write the output to.
* `1 3 5`: A list of line numbers to extract from each file. Can be any number of line numbers.
