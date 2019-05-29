#!/bin/bash

mysql=$(dpkg-query -W -f='${Status}' mysql-server-5.7 2>/dev/null | grep -c "ok installed")

if [ $mysql -eq 0 ]
then
echo "mysql paigaldus"
sudo apt-get install -y mysql-server-5.7

elif [ $mysql -eq 1 ]
then
echo "mysql on juba peal"
/etc/init.d/mysql status
fi
