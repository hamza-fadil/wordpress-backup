FROM alpine:3.18

RUN apk update && \
    apk add --no-cache mysql-client busybox-suid bzip2 pigz && \
    mkdir /backups

ENV MYSQL_ENV_MYSQL_HOST mysql
ENV BACKUP_TIME 0 3 * * *

COPY docker-entrypoint.sh /entrypoint.sh
COPY backup restore /bin/

RUN chmod +x /entrypoint.sh /bin/backup /bin/restore

VOLUME /backups

ENTRYPOINT ["/entrypoint.sh"]
CMD ["crond", "-f"]
