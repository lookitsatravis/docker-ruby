FROM lookitsatravis/docker-base:1.0.0
MAINTAINER Travis Vignon <travis@lookitsatravis.com>

ENV RUBY_VERSION 2.3.0

ONBUILD RUN git clone https://github.com/rbenv/ruby-build.git
ONBUILD RUN cd ruby-build && ./install.sh
ONBUILD RUN ruby-build $RUBY_VERSION /usr/local

ONBUILD RUN echo "gem: --no-document" > ~/.gemrc

ONBUILD RUN gem install bundler

ONBUILD CMD /bin/bash
