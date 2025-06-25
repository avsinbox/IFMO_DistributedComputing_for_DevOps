FROM haproxy:3.2.1

USER root

ENV CONSUL_VERSION=1.20.6
ENV CONSUL_TEMPLATE_VERSION=0.41.0

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        unzip \
        supervisor \
        netcat-openbsd \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    \
    && curl -fsSL https://hashicorp-releases.yandexcloud.net/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip \
    && unzip -j consul.zip consul -d /usr/local/bin \
    && chmod +x /usr/local/bin/consul \
    && rm consul.zip \
    \
    && curl -fsSL https://hashicorp-releases.yandexcloud.net/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
    && unzip -j consul-template.zip consul-template -d /usr/local/bin \
    && chmod +x /usr/local/bin/consul-template \
    && rm consul-template.zip \
    \
    && mkdir -p /consul/config /consul/data /consul-template/config /etc/supervisor/conf.d /var/log/supervisor /var/run/supervisor /var/run/haproxy \
    && chown -R haproxy:haproxy /consul /consul-template /etc/supervisor /var/log/supervisor /var/run/supervisor /var/run/haproxy /usr/local/etc/haproxy

COPY --chown=haproxy:haproxy consul-template.hcl /consul-template/config/consul-template.hcl
COPY --chown=haproxy:haproxy haproxy.ctmpl /consul-template/config/haproxy.ctmpl
COPY --chown=haproxy:haproxy haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY --chown=haproxy:haproxy supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --chown=haproxy:haproxy --chmod=755 delayed-startup.sh /delayed-startup.sh
COPY --chown=haproxy:haproxy --chmod=755 entrypoint.sh /entrypoint.sh

USER haproxy

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
