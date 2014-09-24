#!/bin/sh

# usage: ./install_odoo_dependencies.sh

$AS_VAGRANT=sudo -u vagrant

if [ "x$VAGRANT_ODOO_DEPENDENCIES" == "x" ]; then
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo apt-get update
	sudo apt-get install -y git
	sudo apt-get install -y python-pip
	sudo apt-get install -y python-dev
	sudo apt-get install -y libxml2-dev libxslt-dev
	sudo apt-get install -y postgresql
	sudo apt-get install -y python-psycopg2
	sudo apt-get install -y libpq-dev
	sudo apt-get install -y libldap2-dev libsasl2-dev libssl-dev
	sudo apt-get install python-virtualenv
	sudo apt-get install bzr
	sudo -u postgres createuser vagrant --superuser

	cd /usr/local/bin
	sudo wget http://sourceforge.net/projects/wkhtmltopdf/files/0.12.1/wkhtmltox-0.12.1_linux-precise-amd64.deb
	sudo dpkg -i wkhtmltox-0.12.1_linux-precise-amd64.deb
	cd /usr/bin
	sudo ln -s ../local/bin/wkhtmltopdf wkhtmltopdf

	export VAGRANT_ODOO_DEPENDENCIES='DONE'
fi

echo "Ready to install Odoo !"
