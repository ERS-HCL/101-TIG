
#!/bin/bash

# Script parameters from arguments
TomcatManagerIP=$1
TomcatUser=$2
TomcatPassword=$3
JolokiaServerIP=$4
RedisIP=$5
MongoDBIP=$6
HostIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
configfile=$7

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
wget $configfile
unzip Configfiles.zip -d /home/

HOME=/root ansible-playbook /home/Configfiles/ansible/docker_install.yml  --extra-vars "HostIP=$HostIP JolokiaServerIP=$JolokiaServerIP RedisIP=$RedisIP TomcatManagerIP=$TomcatManagerIP tomcatuser=$TomcatUser tomcatpwd=$TomcatPassword MongoDBIP=MongoDBIP" -vvv


