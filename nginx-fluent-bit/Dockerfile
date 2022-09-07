FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:stable

ENV AWS_REGION=us-east-1
ENV AWS_S3_BUCKET=test-s3-bucket

RUN yum update -y
RUN yum upgrade -y

RUN amazon-linux-extras install nginx1 -y
RUN yum install logrotate -y
RUN yum install crontabs -y

COPY ./config/nginx.conf /etc/nginx/
COPY ./config/fluent-bit.conf /fluent-bit/etc/
COPY ./config/nginx-logrotate.conf  /etc/logrotate.d/nginx
COPY ./config/nginx-logrotate-crond.conf  /etc/cron.d/
COPY ./config/entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 8088
