FROM alpine:3.8

ENV GCSPROXY_VERSION="0.2.0"

RUN wget https://github.com/daichirata/gcsproxy/releases/download/v${GCSPROXY_VERSION}/gcsproxy_${GCSPROXY_VERSION}_amd64_linux -O /usr/local/bin/gcsproxy && \
    chmod +x /usr/local/bin/gcsproxy && \
    apk add --no-cache gettext nginx dumb-init ca-certificates && \
    rm -rf /etc/nginx && mkdir /run/nginx && chown nginx /run/nginx

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
