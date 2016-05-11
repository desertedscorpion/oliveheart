FROM taf7lwappqystqp4u7wjsqkdc7dquw/needlessbeta
RUN dnf update --assumeyes && dnf install --assumeyes apr-devel apr-util-devel curl-devel gcc gcc-c++ git httpd httpd-devel ImageMagick-devel mariadb-devel mariadb-server nano postfix ruby-devel tar wget && dnf update --assumeyes && dnf clean all && systemctl enable mariadb.service
# MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1) && echo -en "${MYSQL_ROOT_PASSWORD}\n" | mysql_secure_installation
CMD ["/usr/sbin/init"]