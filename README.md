Here is the full content of your **Automated MongoDB Backup to Cloudflare R2** documentation in `.docx` format, provided as plain text so you can copy and paste it directly into Microsoft Word:

---

## **Automated MongoDB Backup to Cloudflare R2**

### **Project Overview**

This project sets up an automated backup system for MongoDB using a Bash script and `cron`, with backups securely uploaded to **Cloudflare R2** via the **AWS CLI**.

---

### **1. Prerequisites**

* MongoDB installed and running
* Cloudflare R2 bucket created (e.g., `mongo-backups`)
* AWS CLI configured for R2 with a profile (`r2`)
* `tar`, `cron`, and `bash` available on the Linux system

---

### **2. AWS CLI Setup for R2**

```bash
aws configure --profile r2
```

When prompted, provide:

* Access Key ID
* Secret Access Key
* Region (e.g., `auto`)
* Output format (e.g., `json`)

Edit or create `~/.aws/config`:

```ini
[profile r2]
region = auto
s3 =
  endpoint_url = https://<ACCOUNT_ID>.r2.cloudflarestorage.com
```

Replace `<ACCOUNT_ID>` with your actual R2 account ID.

---

### **3. Bash Script: `backup-mongo.sh`**

This script performs the following:

* Dumps MongoDB database using `mongodump`
* Compresses the dump into a `.tar.gz` file
* Uploads the archive to R2 using `aws s3 cp`
* Logs the backup activity to `backup.log`

```bash
#!/bin/bash

# Variables
BACKUP_DIR=~/mongo-backups
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
DUMP_NAME=dump-$TIMESTAMP
ARCHIVE_NAME=$DUMP_NAME.tar.gz
LOG_FILE=~/mongo-backups/backup.log

# Create backup directory
mkdir -p $BACKUP_DIR

# Dump the database
mongodump --out $BACKUP_DIR/$DUMP_NAME >> $LOG_FILE 2>&1

# Compress the backup
tar -czvf $BACKUP_DIR/$ARCHIVE_NAME -C $BACKUP_DIR $DUMP_NAME >> $LOG_FILE 2>&1

# Upload to Cloudflare R2
aws s3 cp $BACKUP_DIR/$ARCHIVE_NAME s3://mongo-backups/$ARCHIVE_NAME \
  --endpoint-url=https://<ACCOUNT_ID>.r2.cloudflarestorage.com \
  --profile r2 >> $LOG_FILE 2>&1

# Cleanup dump folder
rm -rf $BACKUP_DIR/$DUMP_NAME

echo "Backup completed at $TIMESTAMP" >> $LOG_FILE
```

Make it executable:

```bash
chmod +x ~/backup-mongo.sh
```

---

### **4. Test the Backup Script**

Run:

```bash
bash ~/backup-mongo.sh
```

Check:

* Backup archive exists in `~/mongo-backups`
* `backup.log` has timestamped entries
* Backup is visible in R2:

```bash
aws s3 ls s3://mongo-backups/ \
  --endpoint-url=https://<ACCOUNT_ID>.r2.cloudflarestorage.com \
  --profile r2
```

---

### **5. Automate with Cron**

To schedule automatic backups every 12 hours:

```bash
crontab -e
```

Add:

```cron
0 */12 * * * bash ~/backup-mongo.sh
```

---

### **6. Project Folder Structure**

```bash
Automated-DB-Backups/
├── backup-mongo.sh       # Backup script
├── backup.log            # Backup logs
└── README.html           # Project documentation (converted to HTML)
```

---

### **7. GitHub Setup**

```bash
cd ~
mkdir Automated-DB-Backups
mv ~/backup-mongo.sh ./Automated-DB-Backups/
mv ~/mongo-backups/backup.log ./Automated-DB-Backups/
mv ~/Automated-DB-Backups.html ./Automated-DB-Backups/README.html
cd Automated-DB-Backups

git init
git remote add origin https://github.com/GeigerJR/Automated-DB-Backups.git
git branch -M main
git add .
git commit -m "Initial commit - automated MongoDB backups to R2"
git push -u origin main
```

---

### **8. Summary**

✅ MongoDB backup runs every 12 hours
✅ Archives stored in `mongo-backups` folder
✅ Archives uploaded to Cloudflare R2
✅ Logs tracked in `backup.log`
✅ Project pushed to GitHub

---
https://roadmap.sh/projects/automated-backups
