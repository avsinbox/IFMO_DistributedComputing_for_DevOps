FROM bitnami/pgbouncer:1.24.1

USER root

ENV CONSUL_VERSION=1.20.6

RUN install_packages unzip supervisor \
    && curl -fsSL https://hashicorp-releases.yandexcloud.net/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip \
    && unzip -j consul.zip consul -d /usr/local/bin \
    && chmod +x /usr/local/bin/consul \
    && rm consul.zip \
    && mkdir -p /consul/data /consul/config /etc/supervisor/conf.d /var/log/supervisor /var/run/supervisor \
    && chown -R 1001:1001 /consul /etc/supervisor /var/log/supervisor /var/run/supervisor

COPY --chown=1001:1001 supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --chown=1001:1001 --chmod=755 entrypoint.sh /entrypoint.sh

USER 1001

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
