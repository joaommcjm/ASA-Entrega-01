#!/bin/bash

# Verifica se os dois argumentos foram passados
if [ "$#" -ne 2 ]; then
  echo "Uso: ./service.sh <serviço> <ação>"
  echo "Exemplo: ./service.sh dns start"
  exit 1
fi

SERVICO=$1
ACAO=$2
DIR="./$SERVICO"

# Verifica se o diretório do serviço existe
if [ ! -d "$DIR" ]; then
  echo "Erro: serviço '$SERVICO' não encontrado."
  exit 1
fi

# Verifica qual ação foi solicitada
if [ "$ACAO" = "start" ]; then
  echo "Iniciando o serviço '$SERVICO'..."
  docker build -t $SERVICO-image $DIR
  docker run -d --name $SERVICO-container $SERVICO-image

elif [ "$ACAO" = "stop" ]; then
  echo "Parando o serviço '$SERVICO'..."
  docker stop $SERVICO-container
  docker rm $SERVICO-container

else
  echo "Ação inválida: $ACAO"
  echo "Ações válidas: start, stop"
  exit 1
fi