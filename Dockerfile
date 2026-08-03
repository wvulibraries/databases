FROM ruby:3.4.10

# Install dependencies
# -------------------------------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y xvfb cron git gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xclip

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
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
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
RUN apt-get install -y libjemalloc2 libjemalloc-dev \
    && JEMALLOC_PATH=$(find /usr -name 'libjemalloc.so.2' 2>/dev/null | head -1) \
    && echo "export LD_PRELOAD=$$JEMALLOC_PATH" >> /etc/environment

# ADD ./scripts/startup.sh /usr/bin/
# RUN chmod -v +x /usr/bin/startup.sh
# ENTRYPOINT ["/usr/bin/startup.sh"]