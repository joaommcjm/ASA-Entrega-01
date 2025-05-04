Passo a Passo para conectar os 3 conteiners juntos:

1- Derrubar todos os conteiners que estão ativos (caso estejam) 
- docker ps -a
- docker stop web bind9
- docker rm web bind9

2- Criar a rede asa_rede
- docker network create asa_rede

3- Subir os conteiners novamente na rede 
- *dar build se não tiver criado a imagem* (cd WEB -> docker build -t meu_web ) (cd DNS docker build -t meu_bind9 .)
- docker run -d --name web --network asa_rede -p 8080:80 meu_web  
- docker run -d --name bind9 --network asa_rede -p 53:53/udp meu_bind9

4- Subir o Adminer
- cd ADMINER
- docker run -d --name adminer --network asa_rede -p 8081:8080 adminer
