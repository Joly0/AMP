#!/bin/bash

whoami


USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}
{
if [ -e "/home/AMP/test" ]
	then
		echo "Testfile exist"
		exec "/home/update.sh"
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"
		exec "/home/chown.sh"
	else
		echo "Testfile doesn´t exist"
		su - AMP -c "touch /home/AMP/test"
		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"
		exec "/home/chown.sh"
fi
}
