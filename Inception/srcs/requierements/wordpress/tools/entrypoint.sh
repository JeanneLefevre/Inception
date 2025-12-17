#!/bin/bash
set -e

# Wait for MariaDB with netcat instead of mysql-client
echo "Waiting for MariaDB..."
until nc -z mariadb 3306; do
    echo "MariaDB is not ready yet..."
    sleep 2
done
echo "MariaDB is ready!"

# Télécharger WordPress si pas encore présent
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --path=/var/www/html --allow-root --force
fi

if ! wp core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    
    if [ -f /var/www/html/wp-config.php ]; then
        echo "Removing existing wp-config.php..."
        rm /var/www/html/wp-config.php
    fi
    
    wp core config --path=/var/www/html \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WORDPRESS_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    wp core install --path=/var/www/html \
        --url=$WORDPRESS_SITE_URL \
        --title="Le site wordpress de Jealefev" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root

    
    wp user create ${WORDPRESS_USER1} ${WORDPRESS_USER1_EMAIL} \
        --role=author \
        --user_pass=${WORDPRESS_USER1_PASSWORD} \
        --path=/var/www/html \
        --allow-root
    
    wp user create ${WORDPRESS_USER2} ${WORDPRESS_USER2_EMAIL} \
    --role=author \
    --user_pass=${WORDPRESS_USER2_PASSWORD} \
    --path=/var/www/html \
    --allow-root
    
fi

# Installer et activer le thème
if wp theme is-installed twentytwentyfour --path=/var/www/html --allow-root; then
    wp theme activate twentytwentyfour --path=/var/www/html --allow-root
else
    wp theme install twentytwentyfour --activate --path=/var/www/html --allow-root
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
