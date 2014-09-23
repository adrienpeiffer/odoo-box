#!/bin/sh

AS_VAGRANT="sudo -u vagrant"
DIR_NAME="instance-$1"
ADDONS_DIR_NAME="$DIR_NAME/$2"

if [ $# -ne 3 ]; then
    echo "Usage : instance OCA_repository_name pull_number"
	echo "For instance : 8.0 account-financial-tools 34"
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

echo "Attempting merge pull request ..."
CWD=`pwd`
cd $ADDONS_DIR_NAME
git pull --no-edit https://github.com/OCA/$2.git pull/$3/head || echo "ERROR ...\nRollback processing ..."; exit 1

echo "DONE!"
echo "Pull request is added !"
