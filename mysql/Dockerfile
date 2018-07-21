ARG MYSQL_VERSION="8.0"

FROM mysql:${MYSQL_VERSION}

LABEL maintainer="Eden Tsai <edentsai231@gmail.com"

ARG TIMEZONE="UTC"
RUN if [ "${TIMEZONE}" != "" ]; then \
        export TIMEZONE_FILE="/usr/share/zoneinfo/${TIMEZONE}" \
            && cat "${TIMEZONE_FILE}" > /dev/null \
            && ln --verbose --symbolic --force "${TIMEZONE_FILE}" "/etc/localtime" \
            && echo "${TIMEZONE}" > "/etc/timezone"; \
    fi

RUN mkdir --parent \
        "/var/lib/mysql" \
        "/var/lib/mysql-files" \
        "/var/run/mysqld/" \
        "/var/log" \
    && chown -R "mysql:root" \
        "/var/lib/mysql" \
        "/var/lib/mysql-files" \
        "/var/run/mysqld/" \
        "/var/log"

COPY "my.cnf" "/etc/mysql/conf.d/my.cnf"

CMD ["mysqld"]

EXPOSE 3306
