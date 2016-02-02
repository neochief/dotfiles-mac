#!/usr/bin/env bash

sudo -v

# NginX
sudo brew services stop nginx
brew install nginx --force

sudo ln -sf /usr/local/etc/nginx /etc/nginx
sudo mkdir -p /var/log/nginx
sudo chmod 777 /var/log/nginx
sudo mkdir -p /var/run
sudo chmod 777 /var/run

sudo mkdir -p /etc/nginx/sites-available/
sudo chmod 777 /etc/nginx/sites-available/
sudo mkdir -p /etc/nginx/sites-enabled/
sudo chmod 777 /etc/nginx/sites-enabled/
sudo mkdir -p /etc/nginx/ssl/
sudo chmod 777 /etc/nginx/ssl/

sudo rm -f /etc/nginx/nginx.conf
sudo ln -sf ~/.dotfiles/www/nginx.conf /etc/nginx/nginx.conf

#sudo vi "+g/^\/home/s/\//#\//" "+x" /etc/auto_master
#sudo umount /home
sudo rm -rf /home
sudo ln -sf /Users /home
sudo mkdir -p /home/forge
sudo chmod 777 /home/forge
mkdir -p ~/www

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

sed -i '' "s/127.0.0.1:9000/127.0.0.1:9001/g" /usr/local/etc/php/7.0/php-fpm.d/www.conf

echo "xdebug.idekey=\"PHPSTORM\"" | sudo tee -a /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini > /dev/null
echo "xdebug.remote_enable=1" | sudo tee -a /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini > /dev/null

sudo brew services restart php70

# Composer
brew install composer --force
composer config -g github-oauth.github.com `git config github.token`

# MySQL
sudo brew services stop mariadb
brew install mariadb --force
mysql_install_db
sudo brew services start mariadb
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

sudo brew services restart mariadb


# Node & NPM
npm install -g grunt-cli


# Selenium
brew services stop selenium-server-standalone
brew install selenium-server-standalone
brew services start selenium-server-standalone
