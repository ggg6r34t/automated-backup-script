# Automated Backup Script

The Automated Backup Script is a Bash script that automates the backup process for specified files or directories. This script is designed to simplify the backup process and provide basic logging functionality.

## Usage

### Running the Script

1. Make the script executable: `chmod +x backup.sh`
2. To perform a backup, run: `./backup.sh /path/to/source /path/to/backup`

### Setting Up Cron Jobs

To automate backups at regular intervals, you can set up a cron job:

1. Open crontab: `crontab -e`
2. Schedule the script, e.g.: `0 2 * * * /path/to/backup.sh /path/to/source /path/to/backup`

Make sure to adjust the paths and timing to match your preferences.

## Configuration

Edit `backup.sh` to set source and backup directories:

```bash
source_dir="/path/to/source"
backup_dir="/path/to/backup"
```

## Examples

### Command-Line Usage

To run the backup script from the command line:

```bash
./backup.sh /home/user/documents /mnt/backup_drive
```

## Logging

The script includes basic logging functionality. Log messages are stored in the `backup.log` file within the backup directory.

### Sample Log File

```
2023-08-28 14:30:00 - Backup completed: /home/user/documents → /mnt/backup_drive/backup_2023-08-28_14-30-00
2023-08-28 14:45:00 - Removed old backup: /mnt/external_drive/backups/backup_2023-08-25_14-30-00
```

Log entries provide information about backup activities and the removal of old backups.

---
