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
├── docker/
│   ├── container1/
│   ├── container2/
│   └── container3/
├── docs/
│   ├── apresentacao.pdf
│   └── roteiro.md
├── README.md
└── docker-compose.yml
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
