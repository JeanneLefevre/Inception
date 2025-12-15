FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    php8.2-fpm php8.2-mysqli php8.2-cli php8.2-curl php8.2-gd php8.2-zip php8.2-mbstring php8.2-xml \
    mariadb-client \
    net-tools procps iproute2 netcat-openbsd \
    curl wget unzip less ca-certificates openssl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

RUN curl -o /tmp/wp.zip https://wordpress.org/latest.zip \
    && unzip /tmp/wp.zip -d /var/www/html \
    && mv /var/www/html/wordpress/* /var/www/html \
    && rm -rf /tmp/wp.zip /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/entrypoint.sh"]
