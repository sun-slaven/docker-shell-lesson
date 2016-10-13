FROM centos:latest
RUN yum install -y wget && yum install -y gcc-c++ && yum install -y pcre pcre-devel  && yum install -y zlib zlib-devel  && yum install -y openssl openssl--devel
RUN cd /usr/local
RUN wget http://nginx.org/download/nginx-1.9.6.tar.gz && tar -zxvf nginx-1.9.6.tar.gz
RUN cd nginx-1.9.6 && ./configure && make && make install
COPY ./list.sh /sunwenfeng/list.sh
COPY ./index.html /sunwenfeng/index.html
COPY ./index.css /sunwenfeng/index.css
COPY ./welcome /sunwenfeng/welcome
RUN sed -in '44s/html/\//g' /usr/local/nginx/conf/nginx.conf
WORKDIR /sunwenfeng
ENTRYPOINT ["sh","list.sh","-path"]
CMD ["/etc/"]
EXPOSE 80
