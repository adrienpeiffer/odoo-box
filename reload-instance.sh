#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : reload-instance 70 or reload-instance 80 "
	exit 1
fi

$AS_VAGRANT=sudo -u vagrant

export HOME=/home/vagrant/

CWD=`pwd`
cd instance-$1
$AS_VAGRANT ./bin/buildout -vvv
cd $CWD
if [ ! -f ./instance-$1/bin/start_openerp ] 
then
	echo "Instance $1 reload error. Please restart them"
	exit 1
fi

sudo service odoo-server-$1 restart

echo "DONE!"
echo "Instance $1 of Odoo is running !"
