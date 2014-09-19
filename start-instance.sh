#!/bin/sh

$AS_VAGRANT=sudo -u vagrant

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : start-instance 70 or start-instance 80 "
	exit 1
fi

echo "Attempting to stop other Odoo instance ..."
sudo service odoo-server-* stop
echo "Attempting to start $1 Odoo instance ..."
sudo service odoo-server-$1 start
echo "DONE!"
echo "Instance $1 of Odoo is started"
