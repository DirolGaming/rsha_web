#!/bin/bash

php=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c "ok installed")

if [ $php -eq 0 ]
then
echo "PHP paigaldus"
sudo apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-curl php7.0-mbstring php7.0-mcrypt php7.0-xml php7.0-xmlrpc

elif [ $php -eq 1 ]
then
echo "php on peal"
php -v
fi
