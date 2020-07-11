#!/bin/bash

su -l amp -c "ampinstmgr upgradeall"
su -l amp -c "ampinstmgr quick '${USERNAME}' '${PASSWORD}'" &
exec tail -f /dev/null