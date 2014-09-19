#!/bin/sh

$AS_VAGRANT=sudo -u vagrant

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : destroy-instance 70 or destroy-instance 80 "
	exit 1
fi

sudo service odoo-server-$1 stop
sudo rm /etc/init/odoo-server-$1.conf
sudo rm /etc/init.d/odoo-server-$1
cd /home/vagrant/odoo
rm -rf instance-$1

echo "DONE!"
echo "Instance $1 of Odoo is destroyed"
