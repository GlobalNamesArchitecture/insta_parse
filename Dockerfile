FROM ruby:2.2.2-slim
MAINTAINER Dmitry Mozzherin

ENV LAST_FULL_REBUILD 2015-06-01

EXPOSE 4334

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mongodb-clients supervisor && \
    apt-get install -y build-essential wget

RUN wget http://nginx.org/download/nginx-1.9.2.tar.gz && \
    tar xvf nginx-1.9.2.tar.gz && \
    cd nginx-1.9.2 && \
    ./configure --with-stream --without-http_rewrite_module && \
    make && \
    make install && \
    mkdir /app
WORKDIR /app
COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN bundle install --without development test
COPY . /app
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY start.sh /

CMD ["/app/start.sh"]
