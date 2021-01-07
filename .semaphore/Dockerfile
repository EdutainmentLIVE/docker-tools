FROM itprotv/stack:v2.5.1

RUN yum update -y \
  && yum install -y \
    lftp \
  && yum clean all \
  && rm -rf /var/cache/yum