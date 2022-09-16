FROM timberio/vector:0.24.1-alpine

ENV INPUT_FILE='postdata*.log'
ENV AWS_REGION='us-east-1'
ENV AWS_S3_BUCKET='test-s3-bueckt'

COPY ./config/vector.toml /etc/vector/vector.toml
COPY ./config/entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "sh -c" "/entrypoint.sh" ]