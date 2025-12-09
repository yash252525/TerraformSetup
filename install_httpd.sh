#!/bin/bash

sudo yum update
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

echo "Hello from web server" > /var/www/html/index.html