# 🚢 ASA - Entrega 01: Docker na Prática

Este repositório contém a entrega da Atividade 01 da disciplina de **Administração de Serviços em Ambientes Computacionais (ASA)**.  
O principal objetivo é **sedimentar os conceitos básicos sobre Docker**, por meio da **implementação e testes de serviços com containers Docker**, trabalhando de forma colaborativa em equipe.

🔗 [Dicas e informações da atividade original](https://github.com/salesfilho/learning-asa/blob/4-Docker%2BDNS%2BHTTP/README.md)

---

## 🧠 Objetivos

- Reforçar os conceitos fundamentais do Docker
- Compreender os principais componentes da plataforma Docker
- Entender como funciona o isolamento de containers
- Criar um cenário funcional com múltiplos containers e comunicação entre eles
- Trabalhar colaborativamente em um projeto versionado no GitHub

---

## 📁 Estrutura do Projeto

```
ASA-Entrega-01/
├── DNS/
│   ├── Dockerfile
│   ├── db.asa.br
│   └── named.conf.local
├── WEB/
│   ├── Dockerfile
│   └── index.html
├── README.md
├── service.bat
└── service.sh
```

---

##    Passo a passo

### 🐳 Subir Todos os Containers com um Único Comando

#### 1️⃣ Parar e remover containers existentes

```bash
docker stop web bind9 adminer 2>/dev/null
docker rm web bind9 adminer 2>/dev/null
```

#### 2️⃣ Criar rede Docker (se não existir)
```bash
docker network create asa_rede 2>/dev/null || true
```

#### 3️⃣ Construir e subir containers
```bash
cd DNS && docker build -t meu_bind9 . && docker run -d --name bind9 --network asa_rede -p 53:53/udp meu_bind9 && cd ..
cd WEB && docker build -t meu_web . && docker run -d --name web --network asa_rede -p 8080:80 meu_web && cd ..
docker run -d --name adminer --network asa_rede -p 8081:8080 adminer:latest
```

#### 4️⃣ Verificar status
```bash
echo ""
echo "✅ CONTAINERS INICIADOS COM SUCESSO!"
echo "===================================="
echo "WEB:      http://localhost:8080"
echo "Adminer:  http://localhost:8081"
echo "           (Servidor: db, Usuário: admin, Senha: senha)"
echo ""
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

---

## 🔧 Tecnologias Utilizadas

- Docker
- Docker Compose
- Ubuntu/Debian (base dos containers)
- Servidores HTTP/DNS (Apache/Nginx e Bind)
- Git + GitHub

---

## 🧱 Componentes e Conceitos Abordados

### 📦 1. Componentes da Solução Docker
- **Docker Engine**
- **Images**
- **Containers**
- **Volumes**
- **Networks**

### 🔐 2. Isolamento com Docker
- Namespaces
- Control Groups (cgroups)
- Filesystem (UnionFS)

### 🔗 3. Cenário Desenvolvido
Três containers configurados com Docker Compose:
1. **Servidor DNS (Bind9)**
2. **Servidor Web (Apache ou Nginx)**
3. **Cliente para testes de resolução e acesso HTTP**

---

## ▶️ Execução do Projeto

### Pré-requisitos

- Docker instalado: [Instalar Docker](https://docs.docker.com/get-docker/)
- Docker Compose instalado

### Passos para executar

```bash
git clone https://github.com/SEU_USUARIO/ASA-Entrega-01.git
cd ASA-Entrega-01
docker compose up --build
```

Acesse os serviços conforme configurado no `docker-compose.yml`.

---

## 🗣️ Apresentação

A apresentação aborda:
- Conceitos teóricos do Docker
- Explicação do cenário proposto
- Demonstração prática com containers em execução
- Vídeo explicativo da atividade

📎 Arquivos disponíveis em `docs/`

---

## 👥 Equipe

- José Eduardo Bezerra de Medeiros - [@eduardobezerraz](https://github.com/eduardobezerraz)
- João Marcos Medeiros Costa - [@joaommcjm](https://github.com/joaommcjm)
- João Victor do Nascimento Mendonça - [@joao-victor212](https://github.com/joao-victor212)

---
