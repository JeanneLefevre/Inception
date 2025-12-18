FROM mariadb:11.3

ENV MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD} \
    MARIADB_DATABASE=${MARIADB_DATABASE} \
    MARIADB_USER=${MARIADB_USER} \
    MARIADB_PASSWORD=${MARIADB_PASSWORD}

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY tools/initdb.sh /docker-entrypoint-initdb.d/00-initdb.sh
RUN chmod +x /docker-entrypoint-initdb.d/00-initdb.sh

EXPOSE 3306
