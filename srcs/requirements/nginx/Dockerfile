FROM  Alpine:3.20

RUN  apt-get update \ 
  && apt-get install -y nginx openssl \
  && rm -rf /var/lib/apt/lists/*

# docker cp nginx:/etc/nginx/sites-available/default ./requirements/nginx/.
# revise it then COPY back
# /etc/nginx/nginx.conf -> /etc/nginx/sites-enabled/default -> /etc/nginx/sites-available/default
COPY  default /etc/nginx/sites-available

RUN  mkdir -p /etc/ssl/certs /etc/ssl/private \
  && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt \
		-subj "/C=AU/ST=SA/L=ADL/CN=achiu.42.fr"

EXPOSE  443

CMD  ["nginx", "-g", "daemon off;"]
