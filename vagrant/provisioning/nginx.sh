HOSTNAME=$1
DIR=$2
URL=$3
PHP=$4
#
# setup nginx
#

sudo cat > /etc/nginx/sites-available/${DIR}.conf <<EOF
server {
    listen 80;
    listen [::]:80 ipv6only=on;

    server_name $HOSTNAME;
    
    root /var/www/$DIR;
    index index.php;
    
    access_log /var/log/nginx-access.log;
    error_log /var/log/nginx-error.log; 

    client_max_body_size 50M;

    gzip on;
    gzip_vary on;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml;
    gzip_disable "MSIE [1-6]\.";

        location ~ /.well-known {
        allow all;
    }

    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

    location = /xmlrpc.php {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

    location ^~ /vagrant {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

    location ~* wp-config.php {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

    location ~* .(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
        expires max;
        log_not_found off;
        access_log off;
    }

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_pass unix:/run/php/php${PHP}-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/${DIR}.conf /etc/nginx/sites-enabled/

# update php.ini to be compatible for some themes
sudo sed -i "s@^upload_max_filesize = 2M@upload_max_filesize = 10M@" /etc/php/${PHP}/fpm/php.ini
sudo sed -i "s@^post_max_size = 8M@post_max_size = 30M@" /etc/php/${PHP}/fpm/php.ini