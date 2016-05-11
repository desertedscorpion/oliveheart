FROM taf7lwappqystqp4u7wjsqkdc7dquw/easternmoose
RUN dnf update --assumeyes && dnf install --assumeyes apr-devel apr-util-devel curl-devel gcc gcc-c++ git httpd httpd-devel ImageMagick-devel mariadb-devel mariadb-server nano postfix ruby-devel tar wget && dnf update --assumeyes && dnf clean all
CMD ["/usr/bin/bash"]