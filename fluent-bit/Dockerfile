FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:stable

ENV AWS_REGION=us-east-1
ENV AWS_S3_BUCKET=test-s3-bucket
ENV INPUT_FILE='postdata-*.log'

COPY ./config/fluent-bit.conf /fluent-bit/etc/

COPY ./config/entrypoint.sh /

RUN chmod +x /entrypoint.sh
