#!/bin/bash

# ASCII Logo for Automated Backup Script
echo "  

                                                                                                                   
 _____       _                     _           _    _____            _                _____            _       _   
|  _  | _ _ | |_  ___  _____  ___ | |_  ___  _| |  | __  | ___  ___ | |_  _ _  ___   |   __| ___  ___ |_| ___ | |_ 
|     || | ||  _|| . ||     || .'||  _|| -_|| . |  | __ -|| .'||  _|| '_|| | || . |  |__   ||  _||  _|| || . ||  _|
|__|__||___||_|  |___||_|_|_||__,||_|  |___||___|  |_____||__,||___||_,_||___||  _|  |_____||___||_|  |_||  _||_|  
                                                                              |_|                        |_|       

"

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

# Function to display a progress bar
print_progress() {
    local width=40
    local percentage=$(( $1 * 100 / $2 ))
    local fill=$(( $width * $percentage / 100 ))
    local progress_bar=$(printf '=%.0s' $(seq 1 $fill))

    printf "\r[%-${width}s] %d%%" "$progress_bar" $percentage
}

# Count the number of files and directories in the source directory
total_files=$(find "$source_dir" -type f | wc -l)

# Show progress message
echo "Backup in progress..."

# Perform backup with progress
copied=0
for item in "$source_dir"/*; do
    cp -r "$item" "$backup_folder"
    copied=$((copied + 1))
    print_progress $copied $total_files
done
echo # Move to a new line after the progress bar

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

# Return "Backup completed" message
echo "Backup completed"
