#!/bin/bash

echo "Running Node-Red"
nohup node-red -p $1 --safe -u /srv/app -t $2 &>/dev/null &

