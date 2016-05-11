#!/bin/bash

docker build -t ninthgrimmercury/oliveheart . &&
    docker build -t freakygamma/oliveheart test &&
    if docker run --interactive freakygamma/oliveheart dnf update --assumeyes | grep "^Last metadata expiration check: 0:0"
    then
	echo dnf was updated within the last ten minutes &&
	    true
    else
	echo dnf was not updated within the last ten minutes &&
	    exit 64 &&
	    true
    fi &&
    docker run --interactive --tty --privileged --detach --volume /sys/fs/cgroup:/sys/fs/cgroup:ro freakygamma/oliveheart &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/olivehear --format="{{.ID}}")) &&
    docker rmi --force freakygamma/oliveheart &&
    docker rmi --force ninthgrimmercury/oliveheart &&
    true
