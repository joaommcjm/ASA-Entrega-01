@echo off
setlocal enabledelayedexpansion

:: Main script controller
if "%1"=="start" (
    if "%2"=="all" (
        call :start_all
    ) else if not "%2"=="" (
        set SERVICO=%2
        call :start_service
    ) else (
        call :help
    )
) else if "%1"=="stop" (
    if not "%2"=="" (
        set SERVICO=%2
        call :stop_service
    ) else (
        call :help
    )
) else if "%1"=="status" (
    call :status
) else (
    call :help
)
exit /b

:: Start all containers
:start_all
echo 🛑 Parando e removendo containers antigos...
docker stop web bind9 adminer 2>nul
docker rm web bind9 adminer 2>nul

echo 🔧 Criando rede 'asa_rede' (se necessário)...
docker network create asa_rede 2>nul || echo.

echo 🐳 Construindo e subindo container DNS...
cd DNS || (echo ❌ Diretório DNS não encontrado! && exit /b 1)
docker build -t meu_bind9 .
docker run -d --name bind9 --network asa_rede -p 53:53/udp meu_bind9
cd ..

echo 🐳 Construindo e subindo container WEB...
cd WEB || (echo ❌ Diretório WEB não encontrado! && exit /b 1)
docker build -t meu_web .
docker run -d --name web --network asa_rede -p 8080:80 meu_web
cd ..

echo 🐳 Subindo container Adminer...
docker run -d --name adminer --network asa_rede -p 8081:8080 adminer:latest

echo.
echo ✅ CONTAINERS INICIADOS COM SUCESSO!
echo ====================================
echo 🌐 WEB:      http://localhost:8080
echo 🛠  Adminer:  http://localhost:8081
echo              (Servidor: db, Usuário: admin, Senha: senha)
echo.
docker ps --format "table {{.Names}}`t{{.Status}}`t{{.Ports}}"
exit /b

:: Stop specific service
:stop_service
echo 🛑 Parando e removendo container '%SERVICO%'...
docker stop %SERVICO%-container
docker rm %SERVICO%-container
echo ✅ Container '%SERVICO%' foi parado e removido.
exit /b

:: Start specific service
:start_service
echo 🐳 Iniciando o serviço '%SERVICO%'...
cd %SERVICO% || (echo ❌ Diretório do serviço '%SERVICO%' não encontrado! && exit /b 1)
docker build -t %SERVICO%-image .
docker run -d --name %SERVICO%-container --network asa_rede %SERVICO%-image
cd ..
echo ✅ Serviço '%SERVICO%' iniciado com sucesso!
exit /b

:: Show status
:status
echo 📊 Status dos containers:
docker ps --format "table {{.Names}}`t{{.Status}}`t{{.Ports}}"
exit /b

:: Show help
:help
echo Uso: service.bat [comando] [serviço]
echo.
echo Comandos disponíveis:
echo   start all      Inicia todos os containers
echo   start [nome]   Inicia um serviço específico
echo   stop [nome]    Para e remove um serviço específico
echo   status         Exibe o status dos containers
echo   help           Mostra esta ajuda
echo.
echo Exemplos:
echo   service.bat start all
echo   service.bat start dns
echo   service.bat stop web
echo   service.bat status
exit /b