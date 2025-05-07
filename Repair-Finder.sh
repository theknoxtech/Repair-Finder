#!/bin/bash

# This script will reset Finder by removing all the .DS_Store files in the current working directory or in the directory you specifiy
# It also removes the Finder plist file. A reboot is required to rebuild the plist
# You can run this in two ways: ./Reset-Finder.sh or ./Reset-Finder.sh /path/to/directroy
# Before you run this script ensure you change the permissions with chmod +x Reset-Finder.sh

# Prompts for confirmation before running 
read -p "Are you sure you want to remove all .DS_Store files in the specified directory and its subdirectories? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
  echo "Deletion cancelled."
  exit 1
fi

# Sets the variable directory to the input path or to current working directory
directory="${1:-.}"

# Outputs the operation being performed based on the input of the script
if [[ -z "$directory" ]]; then
  directory="." # current directory
  echo "Searching in the current directory..."
else
  if [[ ! -d "$directory" ]]; then
    echo "Error: Directory '$directory' not found."
    exit 1
  fi
  echo "Searching in directory: $directory"
fi

# This is action of the script. This finds and removes the .DS_Store files in the specified directory recursively 

find "$directory" -name ".DS_Store" -type f -print0 | while IFS= read -r -d $'\0' file; do
  if [[ -f "$file" ]]; then
    rm "$file"
    echo "Removed: $file"
  fi
done

echo "Finished searching and removing .DS_Store files."




