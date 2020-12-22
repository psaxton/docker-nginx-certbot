#! /bin/sh -u

# Bootstraps missing LetsEncrypt SSL certificates
find /etc/nginx/conf.d -name "*.conf" \
| xargs sed -n 's#^\s*ssl_certificate \(/etc/letsencrypt/live/.*\)\;#\1#p' \
| while read file ; do
      # if key file doesn't exist, create a new key
      if [ ! -f "$file" ]; then
          DOMAIN=$(echo $file | sed -n 's#/etc/letsencrypt/live/\(.\+\)/.*$#\1#p')
          DOMAIN_ADMIN="${LETSENCRYPT_MAINTAINER-admin@$DOMAIN}"

          echo "Creating missing lets encrypt certificate for:: $DOMAIN"
          certbot certonly --standalone -n --agree-tos -m "$DOMAIN_ADMIN" -d $DOMAIN
      fi
  done

exit 0;

