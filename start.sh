#!/bin/bash

exec (su -l amp -c "ampinstmgr quick '${ANSWER_AMPUSER}' '${ANSWER_AMPPASS}'") || bash || tail -f /dev/null