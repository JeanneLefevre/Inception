FROM debian:13-slim

ENV DEBIAN_FRONTEND=noniteractive

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    nginx openssl ca-certificates bash \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/tls /run/nginx

RUN apt-get update && apt-get install -y curl netcat-openbsd

RUN openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/nginx/tls/selfsigned.key \
    -out /etc/nginx/tls/selfsigned.crt \
    -subj "/C=FR/ST=IDF"/L=Paris/O=42/OU=Inception/CN=localhost

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
