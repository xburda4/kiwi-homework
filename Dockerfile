FROM nginx:latest

MAINTAINER Marek Burda

RUN apt-get update
RUN apt-get install -y vim openssl

#RUN apt-get update
#RUN apt-get upgrade -y

RUN /bin/bash -c 'openssl req -x509 -out /etc/nginx/localhost.crt -keyout /etc/nginx/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <(printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")'

ADD default.conf /etc/nginx/conf.d/default.conf

ADD index.html /usr/share/nginx/html/index.html

EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;"]
