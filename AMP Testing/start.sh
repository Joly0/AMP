#!/bin/bash

USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}

if [ -e "/home/AMP/test" ]
	then
		apt-get --only-upgrade install ampinstmgr
		ampinstmgr upgradeall
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"
		exec "/home/chown.sh"
		kill -9 2
	else
		touch /home/AMP/test
		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
		exec "/home/chown.sh"
		kill -9 2
fi
