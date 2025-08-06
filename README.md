Of course. I will add a new section for the author and include the link you provided.
Here is the updated README.md content:
# MongoDB Backup to Cloudflare R2

This project automates the process of backing up a MongoDB database every 12 hours using a shell script. It compresses the backup, uploads it to a Cloudflare R2 bucket using AWS CLI, and logs each operation.

---

## 📁 Project Structure


/mongo-backups/
│
├── backup-mongo.sh       # Shell script to dump, compress, upload, and log
├── backup.log            # Log file to record backup status
├── dump-.tar.gz         # Compressed MongoDB dumps (generated automatically)
├── dump- (dir)          # Raw dumped data before compression

---

## 🔧 Prerequisites

* MongoDB installed
* AWS CLI configured for Cloudflare R2 with a named profile (e.g., `r2`)
* A Linux environment (e.g., EC2 instance)

---

## 💡 Steps

### 1. Set up the Cloudflare R2 Bucket

* Create a bucket named **`mongo-backups`** in Cloudflare R2.
* Note your **`ACCOUNT_ID`**.
* Configure AWS CLI with a profile for R2 by adding the following to your `~/.aws/config` file.

```ini
[profile r2]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
region = auto
endpoint_url = https://<ACCOUNT_ID>.r2.cloudflarestorage.com

2. Create the Backup Script
Save this script as ~/backup-mongo.sh:
#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
BACKUP_DIR="$HOME/mongo-backups"
DUMP_DIR="$BACKUP_DIR/dump-$TIMESTAMP"
ARCHIVE="$BACKUP_DIR/dump-$TIMESTAMP.tar.gz"
LOGFILE="$HOME/backup.log"

# Create a directory to store the dumps
mkdir -p "$DUMP_DIR"

# Perform the MongoDB dump
mongodump --out "$DUMP_DIR"

# Compress the dump directory
tar -czvf "$ARCHIVE" -C "$BACKUP_DIR" "dump-$TIMESTAMP"

# Upload the compressed backup to Cloudflare R2
aws s3 cp "$ARCHIVE" s3://mongo-backups/ \
  --endpoint-url=https://<ACCOUNT_ID>.r2.cloudflarestorage.com \
  --profile r2

# Log the successful backup
echo "$(date): Backup $ARCHIVE uploaded to R2" >> "$LOGFILE"

3. Make the Script Executable
chmod +x ~/backup-mongo.sh

4. Test the Script
bash ~/backup-mongo.sh

5. Schedule with Cron
To run the script automatically, edit your crontab:
crontab -e

Add the following line to run the script every 12 hours:
0 */12 * * * /home/ubuntu/backup-mongo.sh

🧪 Verify Backups
 * Check your local backup folder: ls ~/mongo-backups
 * View the log file: cat ~/backup.log
 * List backups in R2:
   aws s3 ls s3://mongo-backups/ \
  --endpoint-url=https://<ACCOUNT_ID>.r2.cloudflarestorage.com \
  --profile r2

✅ Sample Output
2025-08-06T09:53:20.737+0000 writing admin.system.version...
upload: ./dump-2025-08-06-09-53.tar.gz to s3://mongo-backups/
2025-08-06: Backup /home/ubuntu/mongo-backups/dump-2025-08-06-09-53.tar.gz uploaded to R2

📌 Notes
 * You can customize the backup frequency by changing the cron schedule.
 * Ensure that MongoDB is running and accessible by the mongodump tool.
 * Backups are stored both locally and remotely in Cloudflare R2.
📦 License
This project is open-source under the MIT License.
🧑‍💻 Author
 * GeigerJR
 * Project link: https://roadmap.sh/projects/automated-backups
<!-- end list -->
