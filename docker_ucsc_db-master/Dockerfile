FROM ubuntu:16.04
MAINTAINER Alper Kucukural <alper@kucukural.com>
LABEL Description="UCSC Genome Browser database"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget rsync \
    mysql-server \
    mysql-client-5.7 mysql-client-core-5.7 \
    vim libmysqlclient-dev && \
    apt-get clean

RUN mkdir /data && mkdir /var/run/mysqld

RUN { \
        echo '[mysqld]'; \
        echo 'user = mysql'; \
        echo 'skip-host-cache'; \
        echo 'skip-name-resolve'; \
        echo 'datadir = /data'; \
        echo 'local-infile = 1'; \
        echo 'default-storage-engine = MYISAM'; \
        echo 'bind-address = 0.0.0.0'; \
    } > /etc/mysql/my.cnf
ADD passwd /etc/passwd

RUN chown mysql:mysql /var/run/mysqld

RUN mysqld --initialize-insecure && chown -R mysql:mysql /data

RUN wget http://hgdownload.cse.ucsc.edu/admin/hgcentral.sql

RUN mysqld -u root & \
    sleep 6s &&\
    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'admin'; FLUSH PRIVILEGES" | mysql && \
    echo "create database hgcentral" | mysql && \
    echo "create database hgFixed" | mysql && \
    echo "create database hg38" | mysql && \
    mysql -D hgcentral < hgcentral.sql && \
    rm hgcentral.sql

EXPOSE 3306
ADD startmysql /usr/sbin/startmysql
RUN chmod 755 /usr/sbin/startmysql
CMD ["/usr/sbin/startmysql"]
