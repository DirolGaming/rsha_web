#!/bin/bash

apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')

if [ $apache2 -eq 0 ]
then
        echo "Ayyyyy installing apache"
        sudo  apt-get install apache2
elif [ $apache2 -eq 1 ]
then
echo "Apache is installed showing system status"
service apache2 status
fi

