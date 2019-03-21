#!/bin/bash

whoami

USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}

if [ -e "/home/AMP/test" ]
	then
		echo "Testfile exist"
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"
	else
		echo "Testfile doesn´t exist"
		touch /home/AMP/test
		su - AMP -c whoami
		su - AMP -c "ampinstmgr --strict -quick $USERNAME $PASSWORD & disown"
fi
