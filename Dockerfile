FROM alpine:3.10

RUN apk --update add --no-cache hugo

WORKDIR /var/www

CMD ["hugo", "server", "--bind", "0.0.0.0"]
