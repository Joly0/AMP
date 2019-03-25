#!/bin/bash

USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}

if [ -e "/home/AMP/test" ]
	then
		su - AMP -c "apt-get --only-upgrade install ampinstmgr"
		su - AMP -c "ampinstmgr upgradeall"
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"
		exec "/home/chown.sh"
	else
		touch /home/AMP/test
		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
		exec "/home/chown.sh"
fi
