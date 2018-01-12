
#!/bin/bash

# Script parameters from arguments
TomcatManagerIP=$1
JolokiaServerIP=$2
RedisIP=$3
HostIP=$(dig +short myip.opendns.com @resolver1.opendns.com)


apt-get update
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update
apt-get install ansible -y
apt-get install unzip -y

cd /home/

if [ -e Configfiles.* ];
then
  if [ -d /home/Configfiles ];
  then
        rm -rf Configfiles.*
	rm -rf /home/Configfiles
	echo "directory delete"
  fi  
fi
wget https://raw.githubusercontent.com/lavanyasubbarayalu/101-TIG/master/Configfiles.zip
unzip Configfiles.zip -d /home/


HOME=/root ansible-playbook /home/Configfiles/ansible/docker_install.yml  --extra-vars "HostIP=$HostIP JolokiaServerIP=$JolokiaServerIP RedisIP=$RedisIP TomcatManagerIP=$TomcatManagerIP" -vvv


