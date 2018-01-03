## This file gets executed the first time you do a `vagrant up`, if you want it to
## run again you'll need run `vagrant provision`

PHP=$4

#
# INSTALL DEPENDENCIES
#
sudo apt-get update
sudo apt-get upgrade

sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'

sudo apt-get install -y python-software-properties

# get newer PHP versions
sudo apt-add-repository ppa:ondrej/php
sudo apt-get update

sudo apt-get install -y curl nginx
sudo apt-get install -y mariadb-server
sudo apt-get install -y php${PHP} php${PHP}-fpm \
	php${PHP}-mysql php-pear php${PHP}-xml