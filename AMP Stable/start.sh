#!/bin/bash

USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"changeme123"}

if [ -d "/home/AMP/.ampdata" ]
	then
		su - AMP -c "apt --only-upgrade install ampinstmgr"
		su - AMP -c "ampinstmgr upgradeall"
		su - AMP -c "ampinstmgr -b & disown"
	else
		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
fi
