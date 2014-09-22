#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : build-instance 70 or build-instance 80 "
	exit 1
fi

if [ -f /etc/init/odoo-server-$1.conf ] 
then 
   echo "Instance $1 is already built. Please launch 'ssh -c \"./reload-instance $1\"'"
   exit 1
fi

$AS_VAGRANT=sudo -u vagrant

export HOME=/home/vagrant/

cd /home/vagrant/odoo
$AS_VAGRANT mkdir instance-$1
$AS_VAGRANT mkdir instance-$1/log
CWD=`pwd`
cd ./instance-$1
$AS_VAGRANT ln -s ../buildout-base-$1.cfg buildout-base.cfg
$AS_VAGRANT ln -s ../buildout-$1.cfg buildout.cfg
cd $CWD

$AS_VAGRANT virtualenv instance-$1
$AS_VAGRANT ./instance-$1/bin/pip install zc.buildout

if [ -f /etc/init/odoo-server-$1.conf ] 
then 
   sudo rm /etc/init/odoo-server-$1.conf
fi

if [ -L /etc/init.d/odoo-server-$1 ] 
then 
   sudo rm /etc/init.d/odoo-server-$1
fi

sudo touch /etc/init/odoo-server-$1.conf
echo "setuid vagrant" | sudo tee /etc/init/odoo-server-$1.conf
echo "setgid vagrant" | sudo tee -a /etc/init/odoo-server-$1.conf
echo "exec /home/vagrant/odoo/instance-$1/bin/start_openerp --proxy-mode" | sudo tee -a /etc/init/odoo-server-$1.conf
sudo ln -s /lib/init/upstart-job /etc/init.d/odoo-server-$1

CWD=`pwd`
cd instance-$1
$AS_VAGRANT ./bin/buildout -vvv
cd $CWD
if [ ! -f ./instance-$1/bin/start_openerp ] 
then
	echo "Instance $1 creation error. Please restart them"
	exit 1
fi

sudo service odoo-server-$1 restart

echo "DONE!"
echo "Instance $1 of Odoo is running !"
