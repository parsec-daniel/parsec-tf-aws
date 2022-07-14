#!/bin/bash
wget [insert link to Parsec HPR here]
tar -xzvf gateway_server.tar.gz
cd parsechpr1.0
parsechpr_pub_ip=$(curl ipv4.icanhazip.com -s)
sed -i 's/1.2.3.4/'$parsechpr_pub_ip'/g' parsechpr.service
sudo cp parsechpr /bin
sudo cp parsechpr.service /etc/systemd/system
sudo systemctl start parsechpr && sudo systemctl enable parsechpr
sudo apt update && sudo apt upgrade -y
sudo reboot
