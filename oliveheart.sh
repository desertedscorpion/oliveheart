#!/bin/bash

PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1) &&
    PASSWORD=password && // remove me
    echo -en "\n\n${PASSWORD}\n${PASSWORD}\n\n\n\n" | mysql_secure_installation &&
    sed -e "s#password#${PASSWORD}#" /opt/oliveheart/init.sql | mysql -u root --password=${PASSWORD} &&
    sed -e "s#username: root#username: redmine#" -e "s#password: \"\"#password: \"${PASSWORD}\"#" -e "w/opt/oliveheart/redmine-${MAJOR}-${MINOR}-${PATCH}/configdatabase.yml" /opt/oliveheart/redmine-${MAJOR}-${MINOR}-${PATCH}/config/database.yml.example &&
    mv /opt/oliveheart/redmine-${MAJOR}-${MINOR}-${PATCH} /var/www/redmine &&
    cd /var/www/redmine &&
    mkdir /var/www/redmine/public/plugin_assets &&
    chown apache:apache --recursive /var/www/redmine/{files,log,public/plugin_assets,tmp} &&
    /usr/local/bin/bundle install --without development test &&
    mkdir --parents /usr/local/lib64/ruby/site_ruby/mysql2 &&
    cd /usr/local/share/gems/gems/mysql2-0.3.16/ext/mysql2 &&
    ruby extconf.rb &&
    make &&
    make install &&
    cd /usr/local/share/gems/gems/rmagick-2.13.3/ext/RMagick &&
    ruby extconf.rb &&
    make &&
    make install &&
    cd /var/www/redmine &&
    /usr/local/bin/rake generate_secret_token &&
    RAILS_ENV=production /usr/local/bin/rake db:migrate &&
    RAILS_ENV=production /usr/local/bin/rake redmine:load_default_data &&
    ruby script/rails server webrick -e production &&
    gem install passenger &&
    /usr/local/bin/passenger-install-apache2-module &&
    true

