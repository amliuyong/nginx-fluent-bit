#FROM  nginx:latest
FROM fabiocicerchia/nginx-lua

# RUN apt-get update -y
# RUN apt-get upgrade -y

COPY ./config/nginx.conf /etc/nginx/
COPY ./lib/resty/*.lua /etc/nginx/conf.d/lib/resty/

COPY ./config/docker-entrypoint.sh /

RUN chmod +x ./docker-entrypoint.sh
