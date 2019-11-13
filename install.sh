#!/usr/bin/env bash
#!/bin/bash
mysql_version=5.7.28-1.el7.x86_64
install_path=/opt
mysql_psw="Sinvie@123"
function mysqlInstall(){
# install mysql
mkdir -p /opt/mysql
tar -xvf mysql-${mysql_version}.rpm-bundle.tar -C ${install_path}/mysql
yum remove mysql-libs -y
yum install  numactl -y
yum install net-tools -y
rpm -ivh ${install_path}/mysql/mysql-community-common-${mysql_version}.rpm
rpm -ivh ${install_path}/mysql/mysql-community-libs-${mysql_version}.rpm
rpm -ivh ${install_path}/mysql/mysql-community-client-${mysql_version}.rpm
rpm -ivh ${install_path}/mysql/mysql-community-server-${mysql_version}.rpm
rpm -ivh ${install_path}/mysql/mysql-community-devel-${mysql_version}.rpm
# Edit conf
sed -i '$a\character-set-server = utf8mb4\ncollation-server = utf8mb4_unicode_ci\nsql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' /etc/my.cnf
systemctl restart mysqld
systemctl enable mysqld
clear
# get mysql temp password and edit
temp_psw=$(grep 'temporary password' /var/log/mysqld.log)
temp_psw=${temp_psw##*root@localhost:}
echo "Your MySQL temporary password is: "${temp_psw}
sleep 1
mysql -uroot -p --connect-expired-password <<EOF
set global validate_password_policy = 0;
SET PASSWORD = PASSWORD('Sinvie@123');
grant all privileges on *.* to root@'%' identified by 'Sinvie@123';
EOF
sleep 1
systemctl restart mysqld
# create database
mysql -uroot -p"$mysql_psw" --connect-expired-password <<EOF
create database emplus25;
use emplus25;
set names utf8mb4;
EOF
# import mysql
mysql -uroot -p"$mysql_psw" -Demplus25 --connect-expired-password -e "source ${install_path}/emplus.sql"
systemctl restart mysqld
}

mysqlInstall