FROM local-dtr.patsnap.com/official/centos7

COPY ./Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

RUN yum makecache && yum install -y redis && yum clean all

VOLUME /data

WORKDIR /data

EXPOSE 6379

CMD redis-server --appendonly yes
