FROM squidfunk/mkdocs-material:8.2.6
LABEL maintainer="Tim Sutton, tim@kartoza.com"

COPY action.sh /action.sh

RUN apk add --no-cache bash && chmod +x /action.sh

ENTRYPOINT ["/action.sh"]
