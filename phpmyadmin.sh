#!/bin/bash

phpmyadmin=$(dpkg-query -W -f=’${Status}’ phpmyadmin 2>/dev/null | grep -c “ok”)

if [ $phpmyadmin -eq 0 ]
then
echo “phpmyadmin installeerimine”
sudo apt-get install -y phpmyadmin php-mbstring php-gettext
sudo phpenmod mcrypt
sudo phpenmod mbstring

elif [ $phpmyadmin -eq 1 ]
then
echo “phpmyadmin on juba paigaldatud”
service --status-all | grep php
fi

