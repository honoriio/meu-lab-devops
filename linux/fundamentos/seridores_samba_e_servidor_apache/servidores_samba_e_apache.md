# 📚 Estudos de Linux – Servidor de Arquivos (Samba) e Servidor Web (Apache)

> Documentação criada durante meus estudos em Linux para entender na prática como configurar serviços essenciais de infraestrutura: compartilhamento de arquivos em rede e servidor web.

---

# Índice

- [Introdução](#introdução)
- [Servidor de Arquivos com Samba](#servidor-de-arquivos-com-samba)
  - [O que é o Samba](#o-que-é-o-samba)
  - [Instalação do Samba](#instalação-do-samba)
  - [Configuração do Samba](#configuração-do-samba)
  - [Criando diretório compartilhado](#criando-diretório-compartilhado)
  - [Criando usuários Samba](#criando-usuários-samba)
  - [Testando o compartilhamento](#testando-o-compartilhamento)
  - [Comandos importantes](#comandos-importantes)
- [Servidor Web com Apache](#servidor-web-com-apache)
  - [O que é o Apache](#o-que-é-o-apache)
  - [Instalação do Apache](#instalação-do-apache)
  - [Estrutura de diretórios](#estrutura-de-diretórios)
  - [Criando uma página web](#criando-uma-página-web)
  - [Gerenciamento do serviço](#gerenciamento-do-serviço)
  - [Virtual Hosts](#virtual-hosts)
  - [Comandos importantes](#comandos-importantes-1)
- [Boas práticas de segurança](#boas-práticas-de-segurança)
- [Conclusão](#conclusão)

---

# Introdução

Durante os estudos em Linux, dois serviços aparecem constantemente em ambientes reais de infraestrutura:

- Servidor de arquivos
- Servidor web

Nesta documentação pratiquei:

- Instalação de serviços
- Configuração manual
- Permissões de acesso
- Gerenciamento de serviços com `systemctl`

Os exemplos foram feitos em distribuições baseadas em **Debian/Ubuntu**.

---

# Servidor de Arquivos com Samba

## O que é o Samba

O **Samba** é um software que permite compartilhar arquivos entre sistemas Linux e Windows usando o protocolo **SMB/CIFS**.

Com ele é possível:

- Compartilhar pastas na rede
- Controlar acesso por usuários
- Integrar ambientes Linux com Windows

Muito utilizado em:

- Empresas
- Redes internas
- Laboratórios

---

## Instalação do Samba

Atualizar repositórios:

```bash
sudo apt update
````

Instalar o Samba:

```bash
sudo apt install samba -y
```

Verificar versão:

```bash
samba --version
```

---

## Configuração do Samba

Arquivo principal:

```bash
/etc/samba/smb.conf
```

Abrindo o arquivo:

```bash
sudo nano /etc/samba/smb.conf
```

Backup antes de alterar:

```bash
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bkp
```

---

## Criando diretório compartilhado

Criar diretório:

```bash
sudo mkdir -p /srv/samba/arquivos
```

Ajustar permissões:

```bash
sudo chmod 2775 /srv/samba/arquivos
sudo chown nobody:nogroup /srv/samba/arquivos
```

---

## Configurando o compartilhamento

Adicionar no final do arquivo `smb.conf`:

```ini
[Arquivos]
   path = /srv/samba/arquivos
   browseable = yes
   writable = yes
   guest ok = no
   read only = no
```

### Explicação dos parâmetros

| Parâmetro  | Função                   |
| ---------- | ------------------------ |
| path       | Caminho da pasta         |
| browseable | Mostra na rede           |
| writable   | Permite escrita          |
| guest ok   | Permite acesso sem login |
| read only  | Define somente leitura   |

---

## Criando usuários Samba

Criar usuário no Linux:

```bash
sudo adduser diego
```

Adicionar ao Samba:

```bash
sudo smbpasswd -a diego
```

Ativar usuário:

```bash
sudo smbpasswd -e diego
```

---

## Reiniciar serviço

```bash
sudo systemctl restart smbd
```

Verificar status:

```bash
sudo systemctl status smbd
```

---

## Testando o compartilhamento

No Windows:

```
\\IP_DO_SERVIDOR
```

Exemplo:

```
\\192.168.0.10
```

---

## Comandos importantes

Ver conexões ativas:

```bash
sudo smbstatus
```

Testar configuração:

```bash
testparm
```

Listar compartilhamentos:

```bash
smbclient -L localhost -U usuario
```

---

# Servidor Web com Apache

## O que é o Apache

O **Apache HTTP Server** é um dos servidores web mais utilizados do mundo.

Ele permite:

* Hospedar sites
* Servir aplicações web
* Criar múltiplos sites no mesmo servidor

Protocolos usados:

* HTTP
* HTTPS

---

## Instalação do Apache

Atualizar repositórios:

```bash
sudo apt update
```

Instalar:

```bash
sudo apt install apache2 -y
```

Verificar status:

```bash
sudo systemctl status apache2
```

Se aparecer:

```
active (running)
```

O serviço está funcionando.

---

## Testando no navegador

Abrir:

```
http://localhost
```

ou:

```
http://IP_DO_SERVIDOR
```

Se aparecer a página padrão do Apache, está correto.

---

## Estrutura de diretórios

Diretório principal:

```bash
/var/www/html
```

Arquivo padrão:

```bash
index.html
```

Configurações:

```bash
/etc/apache2
```

Pastas importantes:

| Diretório       | Função                    |
| --------------- | ------------------------- |
| sites-available | Configurações disponíveis |
| sites-enabled   | Sites ativos              |
| mods-available  | Módulos disponíveis       |
| mods-enabled    | Módulos ativos            |

---

## Criando uma página web

Editar:

```bash
sudo nano /var/www/html/index.html
```

Exemplo:

```html
<h1>Servidor Apache funcionando!</h1>
```

Salvar e acessar no navegador.

---

## Gerenciamento do serviço

Iniciar:

```bash
sudo systemctl start apache2
```

Parar:

```bash
sudo systemctl stop apache2
```

Reiniciar:

```bash
sudo systemctl restart apache2
```

Habilitar no boot:

```bash
sudo systemctl enable apache2
```

---

## Virtual Hosts

Permite hospedar múltiplos sites.

Criar arquivo:

```bash
sudo nano /etc/apache2/sites-available/meusite.conf
```

Exemplo:

```apache
<VirtualHost *:80>
    ServerName meusite.local
    DocumentRoot /var/www/meusite
</VirtualHost>
```

Criar diretório do site:

```bash
sudo mkdir /var/www/meusite
```

Ativar site:

```bash
sudo a2ensite meusite.conf
```

Recarregar Apache:

```bash
sudo systemctl reload apache2
```

Testar configuração:

```bash
sudo apache2ctl configtest
```

Se aparecer:

```
Syntax OK
```

Está correto.

---

## Comandos importantes

| Comando                  | Função                            |
| ------------------------ | --------------------------------- |
| apache2ctl -S            | Listar Virtual Hosts              |
| a2ensite                 | Ativar site                       |
| a2dissite                | Desativar site                    |
| a2enmod                  | Ativar módulo                     |
| systemctl reload apache2 | Recarregar sem derrubar o serviço |

---

# Boas práticas de segurança

## Samba

* Não usar acesso guest em produção
* Criar usuários individuais
* Restringir permissões de pastas

---

## Apache

Instalar firewall:

```bash
sudo apt install ufw
```

Liberar portas:

```bash
sudo ufw allow 80
sudo ufw allow 443
```

Ativar:

```bash
sudo ufw enable
```

---

# Conclusão

Com este estudo foi possível aprender:

* Instalação de serviços no Linux
* Configuração de compartilhamento de arquivos
* Criação de servidor web
* Gerenciamento de serviços com systemctl
* Conceitos básicos de infraestrutura

Esses serviços são fundamentais para:

* Administração de sistemas
* DevOps
* Infraestrutura de redes
