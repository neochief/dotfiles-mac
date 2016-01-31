#!/usr/bin/env bash

sudo -v

# NginX
if [ "$(brew ls --versions nginx)" == "" ]; then
brew install nginx
fi

sudo brew services start nginx

sudo ln -sf /usr/local/etc/nginx /etc/nginx
sudo mkdir -p /var/log/nginx
sudo chmod 777 /var/log/nginx
sudo mkdir -p /var/run
sudo chmod 777 /var/run
sudo ln -sf /var/run /run

sudo mkdir -p /etc/nginx/sites-available/
sudo chmod 777 /etc/nginx/sites-available/
sudo mkdir -p /etc/nginx/sites-enabled/
sudo chmod 777 /etc/nginx/sites-enabled/
sudo mkdir -p /etc/nginx/ssl/
sudo chmod 777 /etc/nginx/ssl/

sudo rm -f /etc/nginx/nginx.conf
sudo ln -sf ~/.dotfiles/www/nginx.conf /etc/nginx/nginx.conf
sudo nginx -s reload

sudo vi "+g/^\/home/s/\//#\//" "+x" /etc/auto_master
sudo umount /home
sudo rm -rf /home
sudo ln -sf /Users /home
sudo mkdir -p /home/forge
sudo chmod 777 /home/forge

# PHP 7.0
if [ "$(brew ls --versions php70)" == "" ]; then
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew install php70 \
--with-fpm \
--without-apache \
--with-mysql \
--with-homebrew-curl \
--with-homebrew-openssl \
--without-snmp

brew install php70-xdebug
brew install php70-pcntl
fi
sed -i '' "s/127.0.0.1:9000/127.0.0.1:9001/g" /usr/local/etc/php/7.0/php-fpm.d/www.conf

echo "xdebug.idekey=\"PHPSTORM\"" | sudo tee -a /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini > /dev/null
echo "xdebug.remote_enable=1" | sudo tee -a /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini > /dev/null

sudo brew services start php70

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer config -g github-oauth.github.com `git config github.token`

# MySQL
if [ "$(brew ls --versions mariadb)" == "" ]; then
brew install mariadb

sudo brew services start mariadb

mysql_install_db

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root'" -uroot -p
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'" -uroot -proot
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'" -uroot -proot
# Kill off the demo database
mysql -e "DROP DATABASE test" -uroot -proot
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES" -uroot -proot
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param
fi


# Node & NPM
npm install -g grunt-cli


# Selenium
if [ "$(brew ls --versions selenium-server-standalone)" == "" ]; then
brew install selenium-server-standalone
fi