#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -i input_file -o output_file"
    exit 1
}

# Parse flags for input and output files
while getopts ":i:o:" opt; do
  case $opt in
    i) input_file="$OPTARG"
    ;;
    o) output_file="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
        usage
    ;;
    :) echo "Option -$OPTARG requires an argument." >&2
       usage
    ;;
  esac
done

# Check if both input and output files are provided
if [ -z "$input_file" ] || [ -z "$output_file" ]; then
    usage
fi

# Use grep to filter lines containing subdomains, then sort and remove duplicates
grep -Eo '([a-zA-Z0-9-]+\.)+[a-zA-Z]+' "$input_file" | sort | uniq > "$output_file"

# Output the result
echo "Subdomains saved to $output_file