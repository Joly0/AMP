#!/bin/bash
set -x

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    su -l amp -c "ampinstmgr -o"
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; my_handler' SIGUSR1
trap 'kill ${!}; term_handler' SIGTERM

# run application
su -l amp -c "ampinstmgr upgradeall"
su -l amp -c "ampinstmgr quick '${USERNAME}' '${PASSWORD}'" &
pid="$!"

# wait forever
tail -f /dev/null & 
wait ${!}
