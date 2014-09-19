#!/bin/sh

 cd /home/vagrant/odoo
 find -name ".sh" -exec ln -s odoo/{} ../{} \; 
 cd ..
 chmod u+x *.sh