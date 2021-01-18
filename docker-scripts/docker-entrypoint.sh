#!/bin/bash
cp -npr /root-container/. /root 
service ssh restart
service docker start
exec "$@"
