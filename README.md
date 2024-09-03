

**Script for Backup MongoDB**
=====================================

**Overview**
------------

This project provides a shell script to backup MongoDB databases. The script is designed to be easy to use and customizable to fit your specific backup needs.

**Features**
------------

* Backup entire MongoDB databases or specific collections
* Support for daily backups
* Option to compress backups for efficient storage
* Ability to store backups locally

**Requirements**
---------------

* MongoDB 3.0.15 or later
* Bash shell

**Usage**
-----

To run the backup script, simply execute the `backup.sh` file:
```bash
./backup.sh
```
The script will backup the MongoDB databases specified in the `CREDS` variable to the directory specified in the `BASE_BACKUP_DIR` variable.

**Configuration**
--------------

You can customize the backup script by editing the following variables at the top of the `backup.sh` file:

* `BASE_BACKUP_DIR`: The directory where backups will be stored
* `DATE`: The date format for the backup directory (defaults to `YYYYMMDD`)
* `CREDS`: A list of MongoDB credentials in the format `user|pass|db|filter`

For example:
```bash
CREDS="user1|pass1|db1|.filter(function (c) { return c.indexOf('log_') == -1; })
user2|pass2|db2|"
```
This will backup the `db1` and `db2` databases with the specified credentials.

**Troubleshooting**
-----------------

If you encounter any issues with the backup script, check the logs for error messages.

**License**
-------

This project is licensed under the MIT License. See the `LICENSE` file for details.