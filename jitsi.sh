#! /bin/bash

# copyright: TuanPA
# REQUIMENT: UBUNTU 20.04

HOSTNAME="meet.cmcati.vn"
IP=$(ip addr show ens160 | grep inet | grep -v inet6 | awk '{print $2}' | cut -d'/' -f1)

echo "############################ CHECK IP ##################################"

if [ -z "$IP_ADDR" ]; then
	  exit 1
fi

echo "############################ INSTALL ##################################"

sudo apt update
sudo apt install apt-transport-https -y
sudo apt-add-repository universe
sudo apt update


echo "############################ HOSTNAME ##################################"

sudo hostnamectl set-hostname ${HOSTNAME}

cat << EOF >> /etc/hosts
$IP $HOSTNAME
EOF

echo "############################ ADD PACKAGE ##################################"

sudo curl -sL https://prosody.im/files/prosody-debian-packages.key -o /etc/apt/keyrings/prosody-debian-packages.key
echo "deb [signed-by=/etc/apt/keyrings/prosody-debian-packages.key] http://packages.prosody.im/debian $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/prosody-debian-packages.list
sudo apt install lua5.2 -y
curl -sL https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'
echo "deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/" | sudo tee /etc/apt/sources.list.d/jitsi-stable.list
sudo apt update

echo "############################ OPEN PORT ##################################"

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 10000/udp
sudo ufw allow 22/tcp
sudo ufw allow 3478/udp
sudo ufw allow 5349/tcp
sudo ufw enable
sudo ufw status verbose

echo "############################ INSTALL JITSI ##################################"

sudo apt install jitsi-meet -y
