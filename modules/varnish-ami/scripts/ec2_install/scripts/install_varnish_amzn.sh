#!/bin/bash
BASEDIR=$1

sudo amazon-linux-extras install -y epel
sudo yum install -y jemalloc-devel
sudo printf "[main]\nenabled = 0\n" | sudo tee /etc/yum/pluginconf.d/priorities.conf

curl -s https://packagecloud.io/install/repositories/varnishcache/varnish71/script.rpm.sh | sudo bash
sudo sed -i 's/amazon\/2/el\/7/g' /etc/yum.repos.d/varnishcache_varnish71.repo

sudo yum -y update

sudo yum -y install varnish
sudo systemctl enable varnish

sudo sed -ie "/http2\|pid/d" /usr/lib/systemd/system/varnish.service
sudo systemctl daemon-reload

sudo rm /etc/varnish/default.vcl
sudo mv $BASEDIR/configs/backends.vcl /etc/varnish/
sudo mv $BASEDIR/configs/default.vcl /etc/varnish/
sudo chown -R root. /etc/varnish/

sudo mkdir -p /etc/systemd/system/varnish.service.d/
sudo mv $BASEDIR/configs/varnish-overrides-amzn.conf /etc/systemd/system/varnish.service.d/overrides.conf
sudo systemctl daemon-reload

sudo systemctl restart varnish