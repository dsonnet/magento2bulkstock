rm db.sql
mysqldump -u app -d ygzma21_preinstalled_magento > db.sql
tar --exclude var/cache --exclude var/session -czf backup.tgz .
