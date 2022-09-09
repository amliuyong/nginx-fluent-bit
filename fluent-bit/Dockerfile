FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:stable

COPY ./config/fluent-bit.conf /fluent-bit/etc/

COPY ./config/entrypoint.sh /

RUN chmod +x /entrypoint.sh
