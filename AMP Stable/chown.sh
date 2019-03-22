#!/bin/bash


echo "chown.sh gestartet"
watch -n1 "chown AMP:AMP -R /home/AMP/.ampdata/instances" &>-