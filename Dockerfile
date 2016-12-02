FROM ruby:2.3.1

# Dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    libqt4-dev \
    libqtwebkit-dev \
    unzip \
    wget \
    curl


# Nodejs
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -yq nodejs
RUN npm install -g npm


# Phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && tar -xf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/
ENV PATH="/usr/local/bin/phantomjs:${PATH}"
ENV PATH="/usr/local/bin/chromedriver:${PATH}"
CMD /bin/bash

# Bundle
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
