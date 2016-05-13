FROM taf7lwappqystqp4u7wjsqkdc7dquw/needlessbeta
RUN dnf update --assumeyes && dnf install --assumeyes apr-devel apr-util-devel curl-devel gcc gcc-c++ git httpd httpd-devel ImageMagick-devel mariadb-devel mariadb-server nano postfix ruby-devel tar wget && dnf update --assumeyes && dnf clean all && systemctl enable mariadb.service && mkdir /opt/oliveheart
COPY oliveheart.service /usr/lib/systemd/system/oliveheart.service
COPY oliveheart.sh /opt/oliveheart/oliveheart
COPY init.sql /opt/oliveheart/init.sql
ADD http://www.redmine.org/releases/redmine-3.2.2.tar.gz /opt/oliveheart/redmin.tar.gz
RUN chmod 0500 /opt/oliveheart/oliveheart && systemctl enable oliveheart.service
CMD ["/usr/sbin/init"]