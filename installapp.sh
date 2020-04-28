#!/bin/bash
echo "Hello" > /home/ubuntu/installapp.txt
sudo apt-get update &
wait

sudo rm -f /var/lib/dpkg/lock
sudo dpkg --configure -a &
wait
sudo apt-get update &
wait

sudo apt-get install -y apache2 
#zip unzip php php-xml php-mysql curl php-curl git libapache2-mod-php7.0 &
wait
echo $?
sudo rm -f /var/lib/dpkg/lock
sudo dpkg --configure -a &
wait
sudo systemctl enable apache2
sudo systemctl start apache2

sudo apt-get install -y php7.0 php7.0-cli &
echo $?
wait

sudo apt-get install -y curl php7.0-curl php7.0-mysql &
echo $?
sudo apt-get install -y libapache2-mod-php7.0 &
sudo apt-get -f install -y php-gd &
echo $?
#wait
sudo rm -f /var/lib/dpkg/lock
sudo dpkg --configure -a &
wait

#export COMPOSER_HOME=/home/ubuntu 
#cd /home/ubuntu/
#sudo curl -sS https://getcomposer.org/installer | sudo php 
#sudo cp composer.phar /usr/local/bin/composer 
#sudo ln -s /usr/local/bin/composer /usr/bin/composer
#sudo mv /usr/local/bin/composer /home/ubuntu/composer.phar 

#sudo composer.phar install 
#php composer.phar require aws/aws-sdk-php &
#wait
#echo $?
sudo apt-get install -y awscli &
wait
sleep 10;

#git clone git@github.com:amachira/p360.git /home/ubuntu/
git clone https://github.com/amachira/p360.git /home/ubuntu/p360/

sleep 10;
rm -rf /var/www/html/*
sudo rm -rf /var/www/html/*
#sudo mv /home/ubuntu/vendor   /var/www/html/

sudo mv /home/ubuntu/p360/*.html /var/www/html/
#sudo mv /home/ubuntu/amachira/*.css /var/www/html/
#sudo mv /home/ubuntu/amachira/*.jpg /var/www/html/
#sudo mv /home/ubuntu/amachira/*.png /var/www/html/
#php /var/www/html/connexedb.php
#sudo service apache2 restart &

#sudo crontab -l > mycronedit
#sudo echo "* * * * * php /var/www/html/edit.php" >> mycronedit
#sudo cp mycronedit /var/www/html/ 
#crontab /var/www/html/mycronedit
#sudo apt-get -f install php-gd

sudo service apache2 restart &
wait
sudo chown -R www-data:www-data /var/www/html/
