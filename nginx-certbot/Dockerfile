FROM nginx:stable-alpine

RUN apk add --no-cache certbot-nginx

COPY ./30-bootstrap-letsencrypt-certs.sh /docker-entrypoint.d

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
