from  centos:centos7.4.1708

WORKDIR /program_files/tmps 

RUN yum install -y   automake autoconf libtool make gcc-c++
RUN yum install -y   epel-release.noarch &&  yum install -y ivykis-devel  json-c-devel  wget
RUN yum -y install  glib2-devel openssl-devel  which libnet-devel  \
&& wget  https://codeload.github.com/edenhill/librdkafka/tar.gz/v1.3.0  -O librdkafka-1.3.0.tar.gz \ 
&& wget  https://github.com/syslog-ng/syslog-ng/releases/download/syslog-ng-3.28.1/syslog-ng-3.28.1.tar.gz -O syslog-ng-3.28.1.tar.gz \
&& tar -zxvf librdkafka-1.3.0.tar.gz && cd  librdkafka-1.3.0 \
&& ./configure  --prefix=/program_files/apps  && make && make install \
&& cd   .. \
&& tar -zxvf syslog-ng-3.28.1.tar.gz  && cd syslog-ng-3.28.1 \
&& ./configure --prefix=/program_files/syslog-ng-3.28.1    --with-mongoc=no   --with-librabbitmq-client=no  --enable-stomp=no   --enable-legacy-mongodb-options=no   --enable-json=yes     --disable-smtp     --disable-http --enable-stomp=no --enable-geoip=no  --enable-geoip2=no   --disable-python      --disable-riemann  --enable-kafka  --disable-redis --enable-afsnmp=no  LIBRDKAFKA_CFLAGS=-I/program_files/apps/include  LIBRDKAFKA_LIBS="-L/program_files/apps/lib  -lrdkafka"     --enable-sql=no --enable-native=no  --enable-tcp-wrapper=no --with-ivykis=/usr/lib64/    --enable-spoof-source=no  &&  make  &&  make install   \
&&  rm -rf /program_files/tmps 

