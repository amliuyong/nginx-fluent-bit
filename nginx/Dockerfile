FROM  nginx:latest

ENV AWS_INSTANCE_ID=MyHost

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install cron logrotate -y

COPY ./config/nginx.conf /etc/nginx/
COPY ./config/nginx-logrotate.conf  /etc/logrotate.d/nginx
COPY ./config/nginx-logrotate-crond.conf  /etc/cron.d/
COPY ./config/docker-entrypoint.sh /

RUN chmod 0644 /etc/cron.d/nginx-logrotate-crond.conf /etc/logrotate.d/nginx

RUN crontab /etc/cron.d/nginx-logrotate-crond.conf
RUN chmod +x ./docker-entrypoint.sh
