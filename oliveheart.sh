#!/bin/bash

PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1) &&
    echo -en "\n\n${PASSWORD}\n${PASSWORD}\n\n\n\n" | mysql_secure_installation &&
    sed -e "s#password#${PASSWORD}" /opt/oliveheart/init.sql | mysql -u root --password=${PASSWORD}
