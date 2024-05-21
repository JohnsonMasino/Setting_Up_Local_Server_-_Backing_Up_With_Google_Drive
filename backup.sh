#!/bin/bash

GDRIVE_FOLDER_ID="google_drive_folder_id"
LOCAL_BACKUP_DIR="/path/to/local/backup/storage/folder"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")


DB_NAMES=("db1", "db2", "db3")


backup_database() {
        local DB_NAME=$1
        local BACKUP_FILENAME="${DB_NAME}_${DATE}.sql"
        # Assuming you hid your MySQL credentials in a .my.cnf file in same directory as this script
        mysqldump --defaults-file=${SCRIPT_DIR}.my.cnf ${DB_NAME} > ${LOCAL_BACKUP_DIR}/${BACKUP_FILENAME}

        if [ $? -eq 0 ]; then
                echo "Database backup successful: ${BACKUP_FILENAME}"
        else
                echo "Error: Database backup failed for ${DB_NAME}"
                return 1
        fi

        gdrive files upload --parent ${GDRIVE_FOLDER_ID} ${LOCAL_BACKUP_DIR}/${BACKUP_FILENAME}

        if [ $? -eq 0 ]; then
                echo "Backup for ${DB_NAME} uploaded to Google Drive successfully"
        else
                echo "Error: Backup upload to Google Drive failed for ${DB_NAME}"
                return 1
        fi
        return 0
}

for DB_NAME in "${DB_NAMES[@]}"
do
        echo "Backing up database: ${DB_NAME}"
        backup_database ${DB_NAME}
done