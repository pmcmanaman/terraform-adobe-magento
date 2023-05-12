#!/bin/bash
BASEDIR=$1

curl -s https://packagecloud.io/install/repositories/varnishcache/varnish71/script.deb.sh | sudo bash

sudo apt update
sudo apt -y install varnish
sudo systemctl enable varnish

sudo sed -ie "/http2\|pid/d" /usr/lib/systemd/system/varnish.service
sudo systemctl daemon-reload

sudo rm /etc/varnish/default.vcl
sudo mv $BASEDIR/configs/backends.vcl /etc/varnish/
sudo mv $BASEDIR/configs/default.vcl /etc/varnish/
sudo chown -R root. /etc/varnish/

sudo mkdir -p /etc/systemd/system/varnish.service.d/
sudo mv $BASEDIR/configs/varnish-overrides.conf /etc/systemd/system/varnish.service.d/overrides.conf
sudo systemctl daemon-reload

sudo systemctl restart varnish