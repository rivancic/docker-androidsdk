FROM java:7-alpine
MAINTAINER Renato Ivancic <renato.ivancic@gmail.com>

ENV GRADLE_HOME /usr/local/gradle 
ENV PATH ${PATH}:${GRADLE_HOME}/bin 
ENV GRADLE_USER_HOME /gradle
ENV ANDROID_VERSION android-23
ENV ANDROID_SDK_VERSION 24.4.1
ENV BUILD_TOOLS_VERSION build-tools-23.0.3
ENV GRADLE_VERSION 2.10


ENV ANDROID_HOME /opt/android-sdk-linux
ENV GRADLE_USER_HOME /usr/bin/gradle

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

ENV PATH $PATH:$ANDROID_HOME/tools:$GRADLE_USER_HOME/bin

#RUN apk update
RUN apk add --no-cache ca-certificates
#RUN update-ca-certificates
RUN apk add --no-cache openssl
RUN apk update
RUN apk add curl wget bash 


# Install gradle 
WORKDIR /usr/local
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip && \
    ln -s gradle-$GRADLE_VERSION gradle && \
    echo -ne "- with Gradle $GRADLE_VERSION\n" >> /root/.built
RUN apk update && apk add libstdc++ && rm -rf /var/cache/apk/*


# install 32-bit dependencies
#RUN apt-get update -y && \
#    dpkg --add-architecture i386 && \
#    apt-get update -y && \
#    apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386

# install android SDK
ADD http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz /tmp/android-sdk-linux.tgz
RUN mkdir -p $ANDROID_HOME && \
    tar -xzf /tmp/android-sdk-linux.tgz -C /tmp && \
    mv /tmp/android-sdk-linux/* $ANDROID_HOME && \
    ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | android update sdk --no-ui -a --filter platform-tools,${ANDROID_VERSION},${BUILD_TOOLS_VERSION},extra-android-m2repository,extra-android-support
# clean up
#RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
#    apt-get autoremove -y && \
#    apt-get clean

VOLUME /build

WORKDIR /build

CMD ["gradle", "-version"]

