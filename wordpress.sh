apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
mysql=$(dpkg-query -W -f='${Status}' mysql-server-5.7 2>/dev/null | grep -c "ok installed")
php=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c "ok installed")
wordpress=$(ls -la /var/www/ | grep -c "wordpress")

if [ $apache2 -eq 0 ]
then
        echo "Ayyyyy installing apache"
        sudo  apt-get install apache2
elif [ $apache2 -eq 1 ]
then
echo "Apache is installed showing system status"
service apache2 status

if [ $php -eq 0 ]
then
echo "PHP paigaldus"
sudo apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-curl php7.0-mbstring php7.0-mcrypt php7.0-xml php7.0-xmlrpc

elif [ $php -eq 1 ]
then
echo "php on peal"
php -v

if [ $mysql -eq 0 ]
then
echo "mysql paigaldus"
sudo apt-get install -y mysql-server-5.7

elif [ $mysql -eq 1 ]
then
echo "mysql on juba peal"
/etc/init.d/mysql status

if [ $wordpress -eq 0 ]
then
echo "WordPress Paigaldus"
echo "Andmebaasinimi: "
read -e dbname
echo "Andmebaasi kasutaja: "
read -e dbuser
echo "Andmebaasi parool: "
read -s dbpass
#go into correct directory
cd /var/www/
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 775 wp-content/uploads
echo "Cleaning..."
#remove zip file
rm latest.tar.gz
echo "Wordpress on paigaldatud"

fi


