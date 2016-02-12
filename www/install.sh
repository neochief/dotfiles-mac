#!/usr/bin/env bash

sudo -v

sudo dseditgroup -o edit -a `users` -t user wheel
sudo launchctl config user umask 002
sudo launchctl config system umask 002
umask 002

# NginX
sudo brew services stop nginx
brew install nginx --force

sudo ln -sf /usr/local/etc/nginx /etc/nginx
sudo mkdir -p /var/log/nginx
sudo chmod 777 /var/log/nginx
sudo mkdir -p /var/run
sudo chmod 777 /var/run

sudo chmod -R 1777 /tmp
sudo chmod -R 1777 /var/tmp

sudo mkdir -p /etc/nginx/sites-available/
sudo chmod 777 /etc/nginx/sites-available/
sudo mkdir -p /etc/nginx/sites-enabled/
sudo chmod 777 /etc/nginx/sites-enabled/
sudo mkdir -p /etc/nginx/ssl/
sudo chmod 777 /etc/nginx/ssl/

sudo rm -f /etc/nginx/nginx.conf
sudo ln -sf ~/.dotfiles/www/conf/nginx/nginx.conf /etc/nginx/nginx.conf

sudo vi "+g/^\/home/s/\//#\//" "+x" /etc/auto_master
sudo umount /home || true
sudo rm -rf /home
sudo ln -sf /Users /home
sudo mkdir -p /home/forge
sudo chmod 777 /home/forge
mkdir -p ~/www
sudo chgrp -R _www "$HOME/www"
sudo chmod -R g+s "$HOME/www"
sudo chmod -R 775 "$HOME/www"

# Add current user to nginx group
sudo dseditgroup -o edit -a `users` -t user _www

sudo brew services restart nginx

# PHP 7.0
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew services stop php70
brew install php70 --force \
--with-fpm \
--without-apache \
--with-mysql \
--with-homebrew-curl \
--with-homebrew-openssl \
--without-snmp

brew install php70-xdebug

sudo rm -f /usr/local/etc/php/7.0/php-fpm.d/www.conf
sudo ln -sf ~/.dotfiles/www/conf/php/php-fpm.d_www.conf /usr/local/etc/php/7.0/php-fpm.d/www.conf
sudo rm -f /usr/local/etc/php/7.0/php-fpm.conf
sudo ln -sf ~/.dotfiles/www/conf/php/php-fpm.conf /usr/local/etc/php/7.0/php-fpm.conf
sudo rm -f /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini
sudo ln -sf ~/.dotfiles/www/conf/php/conf.d_ext-xdebug.ini /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini

sudo brew services restart php70

# Composer
brew install composer --force
composer config -g github-oauth.github.com `git config github.token`

# MySQL
brew services stop mariadb
brew install mariadb --force
mysql_install_db
brew services start mariadb
sleep 1

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root'" -uroot
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'" -uroot -proot
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'" -uroot -proot
# Kill off the demo database
mysql -e "DROP DATABASE test" -uroot -proot
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES" -uroot -proot
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

brew services restart mariadb


# Node & NPM
npm install -g grunt-cli
npm install -g npm-check-updates

# Selenium
brew services stop selenium-server-standalone
brew install selenium-server-standalone --force
brew services start selenium-server-standalone
brew services stop chromedriver
brew install chromedriver --force
brew services start chromedriver

