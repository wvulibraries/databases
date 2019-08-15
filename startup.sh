#!/bin/bash

# set terminal 
export TERM=vt100

# remove PID and start the server
file="./tmp/pids/server.pid"
[ -f $file ] && rm $file

bin/rails s -p 3000 -b '0.0.0.0'