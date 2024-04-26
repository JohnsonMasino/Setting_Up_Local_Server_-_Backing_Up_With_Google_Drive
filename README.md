# STEPS FOR IMPLEMENTING AUTOMATIC DATABASE BACKUP TO GOOGLE DRIVE

## Introduction
This is a practical step by step process of setting up a simple local server and automating a daily backup for it.

## STEP 1: Create a Google cloud console account To Set Up Google Drive API.
### Steps:
- Go to the Google Developers Console [google developer console](https://console.developers.google.com/)
- Create a new project.
- Enable the Google Drive API for your project.
- Create credentials (OAuth 2.0 Client IDs) for your project to access the API. Choose 'Other' as the application type or "Desktop App" is "Other" is not available.
- Download the credentials JSON file. You'll need this later.
### Possible Bugs To be Fixed(Encountered):
- A google approved developer account is preferable.
- Switch the application from testing to publish

## STEP 2: On your Ubuntu Server, install gdrive and authorize.
### Steps:
- Remotely connect to your ubuntu server using SSH key and password.
- Run "sudo wget -O /usr/bin/gdrive https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64" to install gdrive. 
- In the location where gdrive is installed, run "gdrive about" to locate the GitHub repository of the gdrive you just installed. You can check out the documentation there.
- Run "gdrive account add" to add an account to your gdrive. From the application JSON file you downloaded, copy and add your client id and secret. Then follow the prompt to authorize access to your google drive account.
### Possible Bugs to be Fixed(Encountered):
- Since you're connected to a remote server, you might not be able to install the gdrive directly to the server like the "gdrive v3.9.1" version. So what you have to do is to install it in your local machine and export it to your server as thus:
- .[in local machine]: Run "gdrive account add" follow prompt to authorise access to you google drive account
- .[in local machine]: Run "gdrive account export <account name>" (Usually google email being used).
- .[in local machine]: Copy the exported archive to your remote server.
- Now you have to log in to your remote server and import the archive as thus:
- .[in remote server]: Run "gdrive account import <archive path>"
- Run gdrive commands only on the path of it's installation.
- If you are running the gdrive command from the home directory, specify the file path for example, "/usr/bin/gdrive/gdrive version" to verify the installed version, "/usr/bin/gdrive/gdrive account add" to add a new google drive account to your gdrive.

## STEP 3: Install MySQL client for exporting mysql databases(command line tool).
### Steps:
- Run sudo apt-get update and  d sudo apt-get install mysql-client to install on the remote server.
- Do the necessary configurations.

## STEP 4: Create a Folder in Your Google Drive Account to Store the Backup Files.
### Steps:
- Log into your google drive account and create a new folder.
- Note the last part of the folder link as your folder id for later use. See the link: [https://drive.google.com/drive/u/0/folders/13dwNw6qKND-7soAA58-aT8ZRQrcuEPxm](https://drive.google.com/drive/u/0/folders/13dwNw6qKND-7soAA58-aT8ZRQrcuEPxm), "13dwNw6qKND-7soAA58-aT8ZRQrcuEPxm" is the folder id.

## STEP 5: Create a Backup Script (backup.sh) to handle database backup and upload.
### Steps:
- In your remote server, create a backup.sh file to handle database backup and upload.
- Make script executable.
### Possible Bugs to be Fixed (Encountered):
- Ensure all the details in the script are all correct and well organized including file paths.
- Note the file path of the script.

## STEP 6: Configure your crontab to automatically run the script periodically.
### Steps:
- Open your crontab file using "crontab -e" and add the line of code that'll run the script very specified period of time like in 2 days.
- Save and close the crontab
### Possible Bugs to be Fixed(Encountered):
- Ensure the correct path of the script is indicated in the crontab file so it can locate and run it on the specified time.
- Set the crontab to push the output files to a particular file after every backup
- Check for all dependencies, execution permission, logging, syntax, and environment variables of the crontab.
- Check and verify that the cron Deamon is running: Run ps ax | grep cron and look for cron.
- Debian: service cron start or service cron restart
- Ensure you create environment variable based on the backup script requirements.




## STEP 7: Test the Automatic Backup to be Sure Everything is Working Perfectly Fine.
### Steps:
- Manually run the "backup.sh" file to see the backup file it'll create and push to the created google drive folder.
- Set the automatic backup to run let's say 15 mins and see the files being created and uploaded to the google drive folder automatically every 15 mins.
### Possible Bugs to be Fixed(Encountered):
- In case the backup is not executed automatically, check that the provided file path of the backup file is correct in the crontab file.
- Check for the crontab's execution permission, logging, syntax and environmental variables and see everything is set up fine.


#              REQUIREMENTS FOR THE AUTOMATIC BACKUP
## GOOGLE CLOUD CONSOLE ACCOUNT DETAILS:
- Email, Username and Password of a google account for google console
- Or a json file of an account credentials

## THE DETAILS OF THE REMOTE UBUNTU SERVER:
- SSH key (For logging into server)
- Host / Server IP (For importing neccessary files)
- Username (For importing neccessary files)
- Password (For logging into server)

## MARIADB-CLIENT CREDENTIALS (For exporting database):
- Username
- Password

## GOOGLE DRIVE ACCOUNT CREDENTIALS(For logging in and creating a folder to store the backup files) Can be the same account for google cloud console:
- Email
- Password