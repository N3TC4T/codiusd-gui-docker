FROM nginx:alpine

# for htpasswd command
RUN apk add --no-cache --update apache2-utils


RUN rm -f /etc/nginx/conf.d/*

COPY run.sh /
COPY nginx.conf.tmpl /

RUN chmod a+x /run.sh

# use SIGQUIT for graceful shutdown
# c.f. http://nginx.org/en/docs/control.html
STOPSIGNAL SIGQUIT


CMD ["/run.sh"]
