FROM ruby:3.3.4

# Install capybara-webkit deps
RUN apt-get update \
    && apt-get install -y xvfb cron git qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5webkit5-dev \
                          gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xclip

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn
		
# Install our dependencies and rails
RUN gem install bundler \
	&& gem install rails \
	&& mkdir -p /home/databases

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /home/databases
ADD ./ /home/databases
RUN bundle install --jobs=4 --retry=3
RUN yarn install

ADD ./scripts/startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]