#!/bin/bash

# Define variables
source_dir="$1" #/path/to/source_directory
backup_dir="$2" #/path/to/backup_directory
max_backups=5

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# Create timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup folder
backup_folder="$backup_dir/backup_$timestamp"
mkdir -p "$backup_folder"

# Perform backup
cp -r "$source_dir"/* "$backup_folder"

# Log actions
log_file="$backup_dir/backup.log"
echo "$(date +"%Y-%m-%d %H:%M:%S") - Backup of $source_dir to $backup_folder completed." >> "$log_file"

# Rotation
backups=$(ls -d "$backup_dir"/backup_* | sort -r)
count=0
for backup in $backups; do
    if [ $count -ge $max_backups ]; then
        rm -r "$backup"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Removed old backup: $backup" >> "$log_file"
    fi
    count=$((count + 1))
done

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi
