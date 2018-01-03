HOSTNAME=$1
DIR=$2
URL=$3
PHP=$4
SITENAME=$5
DBUSER='wordpress'
DBPASS='thisisnotproductionthisisnotproduction'

#
# Create a database and grant a user some permissions
#
echo "create database if not exists $DBUSER;" | sudo mysql -uroot -proot
echo "grant all on $DBUSER.* to '$DBUSER'@'localhost' identified by '${DBPASS}';" | sudo mysql -uroot -proot
echo "flush privileges;" | sudo mysql -uroot -proot

#
# Install wp-cli
#
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

cd /var/www/${DIR}

sudo rm -f wp-config.php

# 
# wordpress download
# 
wp core download

sudo rm -f wp-config-sample.php

#
# create wp-config
#
wp config create \
	--dbname=${DBUSER} \
	--dbuser=${DBUSER} \
	--dbpass=${DBPASS} \
	--extra-php <<PHP
define('FS_METHOD','direct');
define( 'WP_MEMORY_LIMIT', '96M' );
PHP

# 
# actual db install
#
wp core install \
	--url=$URL \
	--title="${SITENAME}" \
	--admin_user=admin \
	--admin_password=lamepassword \
	--admin_email=not@real.com \
	--skip-email

# 
# activate theme 
# 
wp theme install twentyseventeen --activate

# 
# Testing Leaflet Map Plugin:
# 

wp plugin install leaflet-map --activate

#
# test posts
#
wp post create \
	--post_title='Generic Map' \
	--post_content='[leaflet-map address="toronto"][leaflet-marker]' \
	--post_status=publish

wp post create \
	--post_title='Generic Image Map' \
	--post_content='[leaflet-image][leaflet-marker]' \
	--post_status=publish

wp post create \
	--post_title='Generic GeoJSON' \
	--post_content='[leaflet-map][leaflet-geojson fitbounds=1]' \
	--post_status=publish

wp post create \
	--post_title='Generic Lines' \
	--post_content='[leaflet-map][leaflet-line addresses="Sayulita; Puerto Vallarta;" fitline=1]' \
	--post_status=publish