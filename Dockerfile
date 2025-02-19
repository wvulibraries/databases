FROM ruby:3.2.2

# Install dependencies
# -------------------------------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y xvfb cron git qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5webkit5-dev \
                          gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xclip

# Set the working directory
# -------------------------------------------------------------------------------------------------
WORKDIR /home/databases

# Install Bundler
# -------------------------------------------------------------------------------------------------
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the container
# -------------------------------------------------------------------------------------------------
COPY ./databases/Gemfile ./databases/Gemfile.lock /home/databases/

# Install gems
# -------------------------------------------------------------------------------------------------
RUN bundle install

# Copy the rest of the application code into the container
# -------------------------------------------------------------------------------------------------
ADD ./databases /home/databases

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn
		
# Install node modules
RUN yarn install

# Set the timezone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use JEMALLOC instead
# JEMalloc is a faster garbage collection for Ruby.
# -------------------------------------------------------------------------------------------------
RUN apt-get install -y libjemalloc2 libjemalloc-dev
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so

# ADD ./scripts/startup.sh /usr/bin/
# RUN chmod -v +x /usr/bin/startup.sh
# ENTRYPOINT ["/usr/bin/startup.sh"]