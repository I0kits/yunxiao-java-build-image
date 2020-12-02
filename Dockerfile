FROM registry.cn-beijing.aliyuncs.com/rdc-builds/oracle-jdk:1.8@sha256:3fbe275f87722f8f3ef26a038ece4d1efe38de1f415bc77204290920e4869657

ENV SERVER_IP=127.0.0.1

ENV RUNIT_VERSION=2.1.2
ENV LCC_VERSION=2018-11-01

RUN curl -kL \
    -o runit.tar.gz \
        "http://smarden.org/runit/runit-${RUNIT_VERSION}.tar.gz" \
    && tar -xvzf runit.tar.gz && mv "/admin/runit-${RUNIT_VERSION}" /runit-${RUNIT_VERSION} \
    && rm -rf runit.tar.gz /admin

# Prepare runit.
RUN mkdir -p /service /etc/runit /etc/sv/getty-5 && \
      # ln -s /etc/sv/getty-5 /service/ && \
      cd runit-2.1.2 && package/install && package/install_man && cd .. && \
      cp /runit-2.1.2/command/runit* /sbin/ && \
      cp /runit-2.1.2/etc/2 /etc/runit/ && \
      cp /runit-2.1.2/etc/debian/1 /etc/runit/ && \
      cp /runit-2.1.2/etc/debian/3 /etc/runit/ && \
      cp runit-2.1.2/etc/debian/ctrlaltdel /etc/runit/ && \
      cp runit-2.1.2/etc/debian/getty-tty5/run /etc/sv/getty-5/ && \
      cp runit-2.1.2/etc/debian/getty-tty5/finish /etc/sv/getty-5/ && \
      mv /sbin/init /sbin/init.sysv && ln -s runit-init /sbin/init

# 
RUN curl -kL \
    -o edas-lite-configcenter.tar.gz \
        "https://edas-public.oss-cn-hangzhou.aliyuncs.com/install_package/LCC/${LCC_VERSION}/edas-lite-configcenter.tar.gz" \
    && tar -xvzf edas-lite-configcenter.tar.gz && mv edas-lite-configcenter lcc \
    && chown -R admin:admin /lcc && rm -rf edas-lite-configcenter.tar.gz

COPY . /
RUN chown root:root /etc/init.d/lcc-service && chmod 755 /etc/init.d/lcc-service
RUN update-rc.d -f lcc-service remove && update-rc.d lcc-service defaults

VOLUME ["/lcc", "/etc"]
