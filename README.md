# jasperreports-docker

Este repositório contém a configuração necessária para executar o JasperReports Server Community Edition em um ambiente Docker com PostgreSQL como banco de dados.

## 🚀 Características

- JasperReports Server Community Edition ${JASPERREPORTS_VERSION}
- Apache Tomcat ${TOMCAT_VERSION}
- PostgreSQL 13
- Configuração automatizada
- Persistência de dados via Docker volumes

## 📋 Pré-requisitos

- Docker instalado (versão 19.03.0+)
- Docker Compose instalado (versão 1.27.0+)
- Mínimo de 4GB de RAM disponível
- 2GB de espaço em disco

## 🛠️ Estrutura do Projeto

```
.
├── Dockerfile
├── docker-compose.yml
├── startup.sh
└── README.md
```

## ⚙️ Configuração

### Variáveis de Ambiente

O arquivo `docker-compose.yml` já inclui as configurações padrão, mas você pode modificá-las conforme necessário:

```yaml
environment:
  - DB_HOST=postgres
  - DB_PORT=5432
  - DB_NAME=jasperserver
  - DB_USERNAME=jasperuser
  - DB_PASSWORD=jasperpassword
```

## 🚀 Como Executar

1. Clone o repositório:
```bash
git clone <url-do-repositorio>
cd <nome-do-repositorio>
```

2. Inicie os containers:
```bash
docker-compose up -d
```

3. Aguarde a inicialização (pode levar alguns minutos na primeira execução):
```bash
docker-compose logs -f
```

4. Acesse o JasperReports Server:
   - URL: http://localhost:8080/jasperserver
   - Usuário padrão: jasperadmin
   - Senha padrão: jasperadmin

## 🛑 Como Parar

Para parar os containers:
```bash
docker-compose down
```

Para parar e remover os volumes (isso apagará todos os dados):
```bash
docker-compose down -v
```

## 📦 Volumes

O Docker Compose configura um volume persistente para o PostgreSQL:
- `postgres_data`: Armazena todos os dados do banco de dados

## 🔧 Manutenção

### Logs

Para ver os logs do JasperReports Server:
```bash
docker-compose logs -f jasperserver
```

Para ver os logs do PostgreSQL:
```bash
docker-compose logs -f postgres
```

### Backup

Para fazer backup do banco de dados:
```bash
docker-compose exec postgres pg_dump -U jasperuser jasperserver > backup.sql
```

## 🔒 Segurança

Por padrão, o sistema usa senhas básicas para desenvolvimento. Em ambiente de produção, você deve:

1. Alterar todas as senhas padrão
2. Configurar SSL/TLS
3. Implementar políticas de backup
4. Revisar as permissões dos volumes

## 🐛 Problemas Comuns

### O JasperReports Server não inicia

1. Verifique se o PostgreSQL está rodando:
```bash
docker-compose ps
```

2. Verifique os logs:
```bash
docker-compose logs jasperserver
```

3. Certifique-se de que há memória suficiente disponível

### Erro de conexão com o banco de dados

1. Verifique as variáveis de ambiente no docker-compose.yml
2. Confirme se o serviço do PostgreSQL está rodando
3. Verifique os logs do PostgreSQL

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📊 Versões

- JasperReports Server: 8.1.0
- Tomcat: 9.0.73
- PostgreSQL: 13

## 🤝 Contribuindo

1. Faça um Fork do projeto
2. Crie sua Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request
