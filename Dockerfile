FROM alpine:latest
LABEL maintainer "git@twoitguys.com"

RUN addgroup -S icecast && \
    adduser -S icecast

RUN apk add --update \
        icecast \
        gettext \
        mailcap && \
    rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY icecast.tmpl /icecast.tmpl
RUN chmod +x /docker-entrypoint.sh

ENV ICECAST_ADMIN_USERNAME=${ICECAST_ADMIN_USERNAME:-admin}
ENV ICECAST_ADMIN_EMAIL=${ICECAST_ADMIN_EMAIL:-none}
ENV ICECAST_ADMIN_PASSWORD=${ICECAST_ADMIN_PASSWORD:-admin}
ENV ICECAST_SOURCE_PASSWORD=${ICECAST_SOURCE_PASSWORD:-admin}
ENV ICECAST_RELAY_PASSWORD=${ICECAST_RELAY_PASSWORD:-admin}
ENV ICECAST_LOCATION=${ICECAST_LOCATION:-MilkyWay}
ENV ICECAST_HOSTNAME=${ICECAST_HOSTNAME:-Pluto}
ENV ICECAST_PORT=${ICECAST_PORT:-8000}
ENV ICECAST_MAX_CLIENTS=${ICECAST_MAX_CLIENTS:-100}
ENV ICECAST_MAX_SOURCES=${ICECAST_MAX_SOURCES:-100}

EXPOSE ${ICECAST_PORT:-8000}
VOLUME ["/var/log/icecast"]
CMD ["/docker-entrypoint.sh"]
