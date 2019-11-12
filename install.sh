#!/usr/bin/env bash
#!/bin/bash
mysql_version=5.7.28-1.el7.x86_64
install_path=/opt
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
sed -i '$a\character-set-server = utf8mb4\ncollation-server = utf8mb4_unicode_ci\nsql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' /etc/my.cnf

systemctl restart mysqld
systemctl enable mysqld
mysql_psw=$(grep 'temporary password' /var/log/mysqld.log)
mysql_psw=${mysql_psw##*root@localhost:}
echo ${mysql_psw}
#mv /etc/my.cnf /etc/my.cnf.back
#cat > /etc/my.cnf <<EOT
#[mysql]
#user=root
#password="${mysql_psw}"
#EOT
#
#systemctl restart mysqld
#mysql  --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Sinvie@123'"
#rm -rf /etc/my.cnf
#mv /etc/my.cnf.back /etc/my.cnf
#mysql_psw=Sinvie@123
#systemctl restart mysqld
mysql_config_editor set --login-path=${install_path} --host=localhost --user=username --password

mysql -uroot -p"$mysql_psw" --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Sinvie@123'"
systemctl restart mysqld
mysql_psw=Sinvie@123
mysql -uroot -p"$mysql_psw" --connect-expired-password -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${mysql_psw}' WITH GRANT OPTION"

systemctl restart mysqld

mysql -uroot -p"$mysql_psw" <<EOF
create database emplus25;
use emplus25;
set names utf8mb4;
EOF

mysql -uroot -p"$mysql_psw" -D emplus25 --connect-expired-password -e "source ${install_path}/emplus.sql"


