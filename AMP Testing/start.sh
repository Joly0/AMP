#!/bin/bash

USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}

if [ -e "/home/AMP/test" ]
then
	echo "Testfile exist"
	su - root -c "apt-get --only-upgrade install ampinstmgr"
	su - root -c "ampinstmgr upgradeall & disown"
	su - AMP -c "chown AMP:AMP -R /home/AMP"
	su - AMP -c "ampinstmgr startinstance ADS01 & disown"
	exec "/home/chown.sh"	
else

	echo "Testfile doesn´t exist"
	su - AMP -c "chown AMP:AMP -R /home/AMP" 
	su - AMP -c "touch /home/AMP/test"
	su - AMP -c "chmod 777 /home/AMP/test && chown AMP:AMP /home/AMP/test"
	su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
	exec "/home/chown.sh"	
fi
