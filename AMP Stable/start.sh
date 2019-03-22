#!/bin/bash


USERNAME=${USERNAME:-"admin"}

PASSWORD=${PASSWORD:-"password"}


if [ -e "/home/AMP/test" ]


	then
	
		su - AMP -c "chown AMP:AMP -R /home/AMP"

    echo "Ordner wurde ge-chown-ed"
		
		su - AMP -c "ampinstmgr startinstance ADS01 & disown"

    echo "Ampinstmgr wurde gestartet"
		
		exec "/home/chown.sh"
		
	else
	
    echo "Tesdatei existiert nicht und wird gleich erstellt"

		su - AMP -c "chown AMP:AMP -R /home/AMP" 

    echo "Ordner wurde ge-chown-ed"

		su - AMP -c "ampinstmgr quickstart $USERNAME $PASSWORD & disown"

    echo "Ampinstmgr wurde gestartet"
		
		su - AMP -c "touch /home/AMP/test"

    echo "Testdatei wurde erstellt"
		
		su - AMP -c "chmod 777 /home/AMP/test && chown AMP:AMP /home/AMP/test"
		
		exec "/home/chown.sh"
		
fi