#!/bin/sh

 cd /home/vagrant/odoo
 sudo chown vagrant:vagrant *
 find -name "*.sh" -exec ln -s odoo/{} ../{} \; 
 cd ..
 chmod u+x *.sh