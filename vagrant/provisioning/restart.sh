#
# restart services
#

PHP=$4

sudo systemctl restart nginx
sudo systemctl restart php${PHP}-fpm
sudo systemctl restart mysql
