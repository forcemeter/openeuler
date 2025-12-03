ARG BASE=openeuler/openeuler:24.03-lts-sp2
FROM hub.oepkgs.net/${BASE}

ARG TARGETARCH
ARG LOCAL_PATH=/usr/local

ARG TARGETARCH
ARG BUILDARCH
ARG VERSION=21.0.9+10
ARG ARC=x64

ADD data/openEuler.repo /etc/yum.repos.d/openEuler.repo
RUN sed -i 's/22.03-LTS-SP4/24.03-LTS-SP2/g' /etc/yum.repos.d/openEuler.repo \
    && yum install -y curl harfbuzz telnet wget bind-utils net-tools findutils fontconfig freetype \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf /var/tmp/* /tmp/*

# https://www.openlogic.com/openjdk-downloads
RUN curl -fSL --output openjdk.tar.gz https://builds.openlogic.com/downloadJDK/openlogic-openjdk/${VERSION}/openlogic-openjdk-${VERSION}-linux-${ARC}.tar.gz
RUN mkdir -p /usr/local/java/ && tar -xvf openjdk.tar.gz -C /usr/local/java --strip-components=1
RUN rm -f openjdk.tar.gz

ENV JAVA_HOME=/usr/local/java/
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai

CMD ["bash"]