FROM ruby:2.7.8

# Install capybara-webkit deps
RUN apt-get update \
    && apt-get install -y xvfb cron git qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5webkit5-dev \
                          gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xclip

# Node.js - Use an older version compatible with Rails 5.2
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Install specific versions compatible with Rails 5.2 and Ruby 2.7.8
RUN gem install bundler -v 2.3.26

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /home/databases
ADD ./ /home/databases

# Install dependencies from Gemfile
RUN bundle _2.3.26_ install --jobs=4 --retry=3
RUN yarn install

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]