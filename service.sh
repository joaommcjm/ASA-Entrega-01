#!/bin/bash

# Função para iniciar todos os containers
function start_all() {
  echo "🛑 Parando e removendo containers antigos..."
  docker stop web bind9 adminer 2>/dev/null
  docker rm web bind9 adminer 2>/dev/null

  echo "🔧 Criando rede 'asa_rede' (se necessário)..."
  docker network create asa_rede 2>/dev/null || true

  echo "🐳 Construindo e subindo container DNS..."
  cd DNS || { echo "❌ Diretório DNS não encontrado!"; exit 1; }
  docker build -t meu_bind9 .
  docker run -d --name bind9 --network asa_rede -p 53:53/udp meu_bind9
  cd ..

  echo "🐳 Construindo e subindo container WEB..."
  cd WEB || { echo "❌ Diretório WEB não encontrado!"; exit 1; }
  docker build -t meu_web .
  docker run -d --name web --network asa_rede -p 8080:80 meu_web
  cd ..

  echo "🐳 Subindo container Adminer..."
  docker run -d --name adminer --network asa_rede -p 8081:8080 adminer:latest

  echo ""
  echo "✅ CONTAINERS INICIADOS COM SUCESSO!"
  echo "===================================="
  echo "🌐 WEB:      http://localhost:8080"
  echo "🛠  Adminer:  http://localhost:8081"
  echo "              (Servidor: db, Usuário: admin, Senha: senha)"
  echo ""
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# Função para parar e remover um serviço específico
function stop_service() {
  echo "🛑 Parando e removendo container '$SERVICO'..."
  docker stop $SERVICO-container
  docker rm $SERVICO-container
  echo "✅ Container '$SERVICO' foi parado e removido."
}

# Função para iniciar um serviço específico
function start_service() {
  echo "🐳 Iniciando o serviço '$SERVICO'..."
  cd $DIR || { echo "❌ Diretório do serviço '$SERVICO' não encontrado!"; exit 1; }
  docker build -t $SERVICO-image .
  docker run -d --name $SERVICO-container --network asa_rede $SERVICO-image
  cd ..
  echo "✅ Serviço '$SERVICO' iniciado com sucesso!"
}

# Função para mostrar o status dos containers
function status() {
  echo "📊 Status dos containers:"
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# Função para exibir ajuda
function help() {
  echo "Uso: ./service.sh [comando] [serviço] [ação]"
  echo ""
  echo "Comandos disponíveis:"
  echo "  start     Inicia todos os containers"
  echo "  stop      Para e remove um serviço específico"
  echo "  status    Exibe o status dos containers"
  echo "  help      Mostra esta ajuda"
}

# Lógica de controle do script
if [ "$1" == "start" ] && [ "$2" == "all" ]; then
  start_all
elif [ "$1" == "start" ] && [ "$2" ]; then
  SERVICO=$2
  DIR="./$SERVICO"
  start_service
elif [ "$1" == "stop" ] && [ "$2" ]; then
  SERVICO=$2
  stop_service
elif [ "$1" == "status" ]; then
  status
else
  help
fi