#!/bin/bash

su - l amp -c "ampinstmgr upgradeall"
exec su -l amp -c "ampinstmgr quick '${USERNAME}' '${PASSWORD}'" || bash || tail -f /dev/null