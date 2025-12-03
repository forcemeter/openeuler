ARG BASE=openeuler/openeuler:22.03-lts-sp4
FROM ${BASE}

ARG TARGETARCH
ARG LOCAL_PATH=/usr/local

ARG TARGETARCH
ARG BUILDARCH
ARG VERSION=17.0.13+11
ARG ARC=x64

# https://www.openlogic.com/openjdk-downloads
RUN curl -fSL --output openjdk.tar.gz https://builds.openlogic.com/downloadJDK/openlogic-openjdk/${VERSION}/openlogic-openjdk-${VERSION}-linux-${ARC}.tar.gz
RUN mkdir -p /usr/local/java/ && tar -xvf openjdk.tar.gz -C /usr/local/java --strip-components=1
RUN rm -f openjdk.tar.gz

ENV JAVA_HOME=/usr/local/java/
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

ADD data/openEuler.repo /etc/yum.repos.d/openEuler.repo
RUN yum install -y harfbuzz telnet wget bind-utils net-tools findutils fontconfig freetype

ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai

CMD ["bash"]