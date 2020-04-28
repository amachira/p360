FROM ubuntu 
#RUN apt-get update -y
ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update - && apt-get install -y apache2 
#ENV TZ=US
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN apt-get update -y
RUN apt-get install -y apache2-utils 
#RUN apt-get clean 
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80
CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
#CMD [apache2ctl, -D, FOREGROUND]
