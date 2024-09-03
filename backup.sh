#!/bin/bash

# Settings
BASE_BACKUP_DIR="your/backups"
DATE=$(date +%Y%m%d)
CREDS="user1|pass1|db1|.filter(function (c) { return c.indexOf('log_') == -1; })
user2|pass2|db2|"

# today backup dir
TODAY_BACKUP_DIR="$BASE_BACKUP_DIR/$DATE"
mkdir -p "$TODAY_BACKUP_DIR"

# Iterate over credentials
while IFS='|' read -r USER PASS DB FILTER; do
	# Create user backup dir
	USER_BACKUP_DIR="$TODAY_BACKUP_DIR/$USER"
	mkdir -p "$USER_BACKUP_DIR"

	# List collections
	COLLECTIONS=$(mongo --username "$USER" --password "$PASS" --authenticationDatabase "$DB" "localhost:27017/$DB" --quiet --eval "db.getCollectionNames()$FILTER.join(' ')")

	for COLLECTION in $COLLECTIONS; do
		# Make dump
		mongodump --username="$USER" --password="$PASS" --authenticationDatabase="$DB" --host=localhost --port=27017 --db="$DB" --collection="$COLLECTION" --out="$USER_BACKUP_DIR/$COLLECTION"

		# Build tar gz
		tar -czf "$USER_BACKUP_DIR/${USER}.${DB}.${COLLECTION}.tar.gz" -C "$USER_BACKUP_DIR" "$COLLECTION"

		# Remove dump
		rm -rf "$USER_BACKUP_DIR/$COLLECTION"
	done
done <<<"$CREDS"

# Remove old backups
find "$BASE_BACKUP_DIR" -mindepth 1 -maxdepth 1 -type d ! -name "$DATE" -exec rm -rf {} \;

echo "Backups completed"
