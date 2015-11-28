FROM ubuntu:14.10
MAINTAINER Travis Vignon <travis@lookitsatravis.com>

ENV RUBY_VERSION 2.2.3
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# System upgrade
RUN apt-get -qq update && \
    apt-get -qqy upgrade; \
    apt-get -qqy install \
      build-essential \
      software-properties-common \
      python-software-properties \
      openssl \
      ca-certificates \
      git-core \
      unzip \
      imagemagick \
      curl \
      bison \
      zlib1g-dev \
      libgdbm-dev \
      libreadline6-dev \
      libncurses5-dev \
      libyaml-dev \
      libssl-dev \
      libxslt-dev \
      libxml2-dev \
      libffi-dev \
      openjdk-7-jre-headless; \
    apt-get clean -y; \
    apt-get autoremove -y

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

RUN echo "America/Chicago" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

ONBUILD RUN git clone https://github.com/rbenv/ruby-build.git
ONBUILD RUN cd ruby-build && ./install.sh
ONBUILD RUN ruby-build $RUBY_VERSION /usr/local

ONBUILD RUN echo "gem: --no-document" > ~/.gemrc

ONBUILD RUN gem install bundler

ONBUILD CMD /bin/bash
