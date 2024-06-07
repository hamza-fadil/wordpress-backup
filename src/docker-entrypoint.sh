#!/bin/sh

if ! [ -f /etc/crontabs/root ]; then
  echo "Creating cron entry to start backup at: $BACKUP_TIME"
  
  cat <<-EOF > /etc/crontabs/root
MYSQL_ENV_MYSQL_HOST=$MYSQL_ENV_MYSQL_HOST
MYSQL_ENV_MYSQL_USER=$MYSQL_ENV_MYSQL_USER
MYSQL_ENV_MYSQL_DATABASE=$MYSQL_ENV_MYSQL_DATABASE
MYSQL_ENV_MYSQL_PASSWORD=$MYSQL_ENV_MYSQL_PASSWORD
EOF

  # Add cleanup variable if it exists
  if [ -n "$CLEANUP_OLDER_THAN" ]; then
    echo "CLEANUP_OLDER_THAN=$CLEANUP_OLDER_THAN" >> /etc/crontabs/root
  fi

  # Add backup job to cron
  echo "$BACKUP_TIME /bin/backup > /backup.log 2>&1" >> /etc/crontabs/root

  crontab /etc/crontabs/root
fi

echo "Current crontab:"
crontab -l

exec "$@"