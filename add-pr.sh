#!/bin/sh

$AS_VAGRANT=sudo -u vagrant

if [ $# -ne 3 ]; then
    echo "Usage : instance OCA_repository_name pull_number"
	echo "For instance : 8.0 account-financial-tools 34"
	exit 1
fi

$dir_name = "instance_$1" 
cd /home/vagrant/odoo
if [ ! -d $dir_name ]; then
    echo "Error : instance local directory doesn't exist"
	exit 1
fi
$addons_dir_name = "instance_$1/$2"
if [ ! -d $addons_dir_name ]; then
    echo "Error : local repository of $2 doesn't exist"
	exit 1
fi

echo "Attempting merge pull request ..."
CWD=`pwd`
cd $addons_dir_name
git pull --no-edit https://github.com/OCA/$2 pull/$3/head || echo "ERROR"; exit 1

echo "DONE!"
echo "Pull request is added !"
