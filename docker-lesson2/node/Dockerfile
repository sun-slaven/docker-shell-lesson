FROM local-dtr.patsnap.com/official/centos7

COPY Centos-Base.repo /etc/yum.repos.d/

RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

RUN yum install nodejs -y && yum clean all
RUN yum install supervisor -y && yum clean all
RUN yum install nginx -y && yum clean all

COPY container_files /
COPY . /app/

RUN cd /app/ && npm install --production --registry=https://registry.npm.taobao.org

EXPOSE 80

WORKDIR /app/

VOLUME /app/

CMD ["supervisord", "-n"]
