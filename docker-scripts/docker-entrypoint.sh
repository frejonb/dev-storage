#!/bin/bash
cp -npr /root-container/. /root 
service ssh restart
service docker stop
echo '{"hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]}' > /etc/docker/daemon.json
service docker start
exec "$@"
