<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MongoDB Backup to Cloudflare R2</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      background-color: #f4f4f4;
      padding: 40px;
    }
    h1, h2, h3 {
      color: #333;
    }
    code, pre {
      background-color: #eee;
      padding: 5px 10px;
      border-radius: 4px;
      font-family: Consolas, monospace;
    }
    pre {
      overflow-x: auto;
    }
    a {
      color: #0077cc;
    }
    .container {
      background: #fff;
      padding: 20px 30px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      max-width: 900px;
      margin: auto;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>MongoDB Backup to Cloudflare R2</h1>

    <p>This project automates the process of backing up a MongoDB database every 12 hours using a shell script, compresses it, uploads the backup to a Cloudflare R2 bucket using AWS CLI, and logs each operation.</p>

    <h2>📁 Project Structure</h2>
    <pre><code>/mongo-backups/
│
├── backup-mongo.sh       # Shell script to dump, compress, upload, and log
├── backup.log            # Log file to record backup status
├── dump-*.tar.gz         # Compressed MongoDB dumps (generated automatically)
├── dump-* (dir)          # Raw dumped data before compression
</code></pre>

    <h2>🔧 Prerequisites</h2>
    <ul>
      <li>MongoDB installed</li>
      <li>AWS CLI configured for Cloudflare R2 with a named profile (e.g., <code>r2</code>)</li>
      <li>Linux environment (e.g., EC2 instance)</li>
    </ul>

    <h2>💡 Steps</h2>

    <h3>1. Setup the Cloudflare R2 Bucket</h3>
    <ul>
      <li>Create a bucket named <code>mongo-backups</code> in Cloudflare R2.</li>
      <li>Note your <code>ACCOUNT_ID</code>.</li>
      <li>Configure AWS CLI with a profile for R2:</li>
    </ul>

    <pre><code>[profile r2]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
region = auto
endpoint_url = https://&lt;ACCOUNT_ID&gt;.r2.cloudflarestorage.com
</code></pre>

    <h3>2. Create the Backup Script</h3>
    <p>Save this as <code>~/backup-mongo.sh</code>:</p>

    <pre><code>#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
BACKUP_DIR="$HOME/mongo-backups"
DUMP_DIR="$BACKUP_DIR/dump-$TIMESTAMP"
ARCHIVE="$BACKUP_DIR/dump-$TIMESTAMP.tar.gz"
LOGFILE="$HOME/backup.log"

mkdir -p "$DUMP_DIR"
mongodump --out "$DUMP_DIR"

tar -czvf "$ARCHIVE" -C "$BACKUP_DIR" "dump-$TIMESTAMP"

aws s3 cp "$ARCHIVE" s3://mongo-backups/ \
  --endpoint-url=https://&lt;ACCOUNT_ID&gt;.r2.cloudflarestorage.com \
  --profile r2

echo "$(date): Backup $ARCHIVE uploaded to R2" >> "$LOGFILE"
</code></pre>

    <h3>3. Make the Script Executable</h3>
    <pre><code>chmod +x ~/backup-mongo.sh</code></pre>

    <h3>4. Test the Script</h3>
    <pre><code>bash ~/backup-mongo.sh</code></pre>

    <h3>5. Schedule with Cron</h3>
    <p>Edit crontab:</p>
    <pre><code>crontab -e</code></pre>
    <p>Add the following to run every 12 hours:</p>
    <pre><code>0 */12 * * * /home/ubuntu/backup-mongo.sh</code></pre>

    <h2>🧪 Verify Backups</h2>
    <ul>
      <li>Check your local backup folder: <code>ls ~/mongo-backups</code></li>
      <li>View log file: <code>cat ~/backup.log</code></li>
      <li>List backups in R2:</li>
    </ul>

    <pre><code>aws s3 ls s3://mongo-backups/ \
  --endpoint-url=https://&lt;ACCOUNT_ID&gt;.r2.cloudflarestorage.com \
  --profile r2</code></pre>

    <h2>✅ Sample Output</h2>
    <pre><code>2025-08-06T09:53:20.737+0000 writing admin.system.version...
upload: ./dump-2025-08-06-09-53.tar.gz to s3://mongo-backups/
2025-08-06: Backup /home/ubuntu/mongo-backups/dump-2025-08-06-09-53.tar.gz uploaded to R2</code></pre>

    <h2>📌 Notes</h2>
    <ul>
      <li>You can customize the backup frequency by changing the cron schedule.</li>
      <li>Ensure MongoDB is running and accessible by the <code>mongodump</code> tool.</li>
      <li>Backups are stored both locally and remotely in Cloudflare R2.</li>
    </ul>

    <h2>📦 License</h2>
    <p>This project is open source under the MIT License.</p>
  </div>
</body>
</hbtml>

https://roadmap.sh/projects/automated-backups
