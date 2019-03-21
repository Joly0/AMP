#! /bin/bash


USERNAME=${USERNAME:-"admin"}

PASSWORD=${PASSWORD:-"password"}


if [ -e "/home/AMP/test" ]


	then
	
		apt update
		
		apt upgrade
		
		ampinstmgr upgradeall
	
		su - AMP -c "chown AMP:AMP -R /home/AMP"
		
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"
		
		exec "/home/chown.sh"
		
	else
	
		su - AMP -c "chown AMP:AMP -R /home/AMP" 

		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
		
		su - AMP -c "touch /home/AMP/test"
		
		su - AMP -c "chmod 777 /home/AMP/test && chown AMP:AMP /home/AMP/test"
		
		exec "/home/chown.sh"
		
fi
