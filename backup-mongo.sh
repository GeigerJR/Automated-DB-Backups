#!/bin/bash

# === Configuration ===
TIMESTAMP=$(date +'%Y-%m-%d-%H-%M')
BACKUP_DIR="$HOME/mongo-backups"
ARCHIVE_NAME="dump-$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"
BUCKET_NAME="mongo-backups"
PROFILE="r2"
ENDPOINT_URL="https://afda8ac81d6106ccabc137f4e442f868.r2.cloudflarestorage.com"

# === Ensure backup directory exists ===
mkdir -p "$BACKUP_DIR"

# === Dump MongoDB ===
mongodump --out "$BACKUP_DIR/dump-$TIMESTAMP"

# === Compress backup ===
tar -czvf "$ARCHIVE_PATH" -C "$BACKUP_DIR" "dump-$TIMESTAMP"

# === Remove raw dump directory ===
rm -rf "$BACKUP_DIR/dump-$TIMESTAMP"

# === Upload to Cloudflare R2 ===
aws s3 cp "$ARCHIVE_PATH" s3://$BUCKET_NAME/ \
  --endpoint-url=$ENDPOINT_URL \
  --profile $PROFILE

# Delete local backups older than 7 days
find /home/ubuntu/mongo-backups -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;
