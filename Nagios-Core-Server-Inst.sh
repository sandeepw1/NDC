sudo hostnamectl set-hostname nagios-srv
sudo sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0
sudo yum install -y gcc glibc glibc-common wget unzip httpd php php-cli gd gd-devel openssl-devel net-snmp perl -y
sudo yum install -y make gettext autoconf net-snmp-utils epel-release automake tar wget unzip
cd /tmp
wget -O nagioscore.tar.gz https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.5.8.tar.gz
tar xzf nagioscore.tar.gz
cd nagios-4.5.8/
sudo ./configure
sudo make all
sudo make install-groups-users
sudo usermod -a -G nagios apache
sudo make install
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo make install-daemoninit 
sudo systemctl enable httpd.service 
sudo firewall-cmd --zone=public --add-port=80/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo systemctl start httpd
######################################################################
####NAGIOS CORE INSTALLATION COMPLETED SUCCESSFULLY !!!
######################################################################
######################################################################
###NOW INSTALLING NRPE AGENNT !!!! .........WAIT 
#####################################################################
sleep 10
cd /tmp
wget wget --no-check-certificate -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.1.0.tar.gz
tar xvzf nrpe.tar.gz
cd nrpe-nrpe-4.1.0/
sudo ./configure --enable-command
sudo make all
sudo make install-groups-use
sudo make install
sudo make install-config
sudo make install-init
sudo systemctl enable nrpe.service
sudo systemctl start nrpe.service
sudo /usr/local/nagios/libexec/check_nrpe -H 127.0.0.1
###################################################################
##NRPE INSTALLATION FINISHED !!!
###################################################################
##INSTALLING NAGIOS PLUGINS!!! .........WAIT
##################################################################
sleep 10
sudo yum install -y gcc glibc glibc-common make gettext automake autoconf wget openssl-devel net-snmp net-snmp-utils epel-release
sudo yum --enablerepo=crb,epel install perl-Net-SNMP -y
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz
cd nagios-plugins-release-2.2.1
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
###############################################################
##INSTALLATION COMPLETE!!!!
###############################################################
The Nagios web console username is .......  nagiosadmin
The password is .............You Entered during this installation. !!!! Hope you remember :)
##############################################################################################
##Enjoy Monitoring !!!!
#############################################################################################
sleep 10
