FROM timberio/vector:0.24.1-alpine

COPY ./config/vector.toml /etc/vector/vector.toml
COPY ./config/entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]