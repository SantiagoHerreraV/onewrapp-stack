FROM ruby:2.6.3

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    awscli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 1.17.3
RUN apt-get install libicu-dev
RUN bundle install
EXPOSE 3000
# CMD ["rails", "server", "-b", "0.0.0.0"]