#!/bin/sh

AS_VAGRANT="sudo -u vagrant"
DIR_NAME="instance-$1"
ADDONS_DIR_NAME="$DIR_NAME/$2"

if [ $# -ne 2 ]; then
    echo "Usage : instance OCA_repository_name"
	echo "For instance : 8.0 account-financial-tools"
	exit 1
fi

 
cd /home/vagrant/odoo
if [ ! -d $DIR_NAME ]; then
    echo "Error : instance local directory doesn't exist"
	exit 1
fi

if [ ! -d $ADDONS_DIR_NAME ]; then
    echo "Error : local repository of $2 doesn't exist"
	exit 1
fi

echo "Attempting to clean repository ..."
CWD=`pwd`
cd $ADDONS_DIR_NAME
git reset --hard
echo "Local repository $2 is cleaned"
