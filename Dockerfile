FROM alpine:3.10

RUN apk --no-cache add hugo

WORKDIR /var/www

CMD ["hugo", "server", "--bind", "0.0.0.0"]
