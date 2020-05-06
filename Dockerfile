FROM ubuntu:18.04
ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y apache2 
RUN apt-get install -y git curl php libapache2-mod-php
#RUN apt-get clean 

RUN rm /var/www/html/index.html
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80
COPY src/ /var/www/html

CMD [ "php", "/var/www/html/index.php" ]
CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

