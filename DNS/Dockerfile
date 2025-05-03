FROM ubuntu:20.04

RUN apt-get update && apt-get install -y bind9 dnsutils

COPY named.conf.local /etc/bind/named.conf.local
COPY db.asa.br /etc/bind/db.asa.br

CMD ["named", "-g"]