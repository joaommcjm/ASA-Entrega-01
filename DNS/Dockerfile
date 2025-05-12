FROM ubuntu:20.04

# Atualiza o apt e instala os pacotes necessários
RUN apt-get update && apt-get install -y bind9 dnsutils iputils-ping

# Copia os arquivos de configuração para o contêiner
COPY named.conf.local /etc/bind/named.conf.local
COPY db.asa.br /etc/bind/db.asa.br

# Inicia o serviço Bind9
CMD ["named", "-g"]
