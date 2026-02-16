# Gerenciamento de Usuários no Linux (Ubuntu)  
## Minha Jornada de Aprendizado em Linux e Infraestrutura

Este documento faz parte do meu **laboratório pessoal de estudos em Linux e Infraestrutura**.  
Aqui eu documento o processo de **criação e gerenciamento de usuários em um sistema Ubuntu**, entendendo como funcionam usuários, grupos e permissões.

O objetivo não é apenas executar comandos, mas **compreender o impacto de cada ação no sistema**.

---

## 🎯 Objetivo do Estudo

- Criar usuários distintos no sistema
- Separar usuários administrativos de usuários comuns
- Entender grupos e permissões
- Aplicar boas práticas de segurança

---

## 👤 Tipos de Usuários Criados

Durante este estudo, criei os seguintes usuários:

| Usuário | Função | Privilégios |
|------|------|------|
| `admin` | Administrador do sistema | sudo |
| `dev1` | Desenvolvedor | usuário comum |
| `dev2` | Desenvolvedor | usuário comum |

---

## 🔧 Atualização do Sistema

Antes de criar usuários, é uma boa prática garantir que o sistema esteja atualizado.

```bash
sudo apt update && sudo apt upgrade -y
````

---

## ➕ Criação de Usuários

Para criar usuários no Ubuntu, utilizei o comando `adduser`, que já cria o diretório HOME e solicita a senha.

### Criando o usuário administrador

```bash
sudo adduser admin
```

Durante a criação, o sistema solicita:

* Senha
* Informações opcionais (nome completo, telefone, etc.)

---

### Criando usuários comuns

```bash
sudo adduser dev1
sudo adduser dev2
```

Esses usuários terão acesso apenas ao próprio diretório HOME e não possuem privilégios administrativos.

---

## 👥 Grupos no Linux

No Linux, **grupos são usados para organizar permissões**.
Um usuário pode pertencer a vários grupos ao mesmo tempo.

### Adicionando usuário ao grupo sudo

Apenas o usuário `admin` foi adicionado ao grupo `sudo`, permitindo executar comandos administrativos.

```bash
sudo usermod -aG sudo admin
```

* `-a` → append (não remove outros grupos)
* `-G` → define grupos suplementares

---

### Verificando grupos dos usuários

```bash
groups admin
groups dev1
groups dev2
```

Esse comando ajuda a confirmar se o usuário possui os grupos corretos.

---

## 🏠 Diretórios HOME

Cada usuário possui seu próprio diretório HOME, criado automaticamente em:

```bash
/home/nome_do_usuario
```

Exemplo:

```bash
/home/admin
/home/dev1
/home/dev2
```

Por padrão:

* Um usuário **não acessa** o HOME de outro
* Isso garante isolamento e segurança

---

## 🔐 Permissões Básicas

Verificando permissões dos diretórios HOME:

```bash
ls -ld /home/*
```

Resultado esperado:

* Proprietário: o próprio usuário
* Grupo: o grupo do usuário
* Permissões restritas

---

## 🔁 Alternar Entre Usuários

Para testar os usuários criados, utilizei o comando `su`.

```bash
su - admin
su - dev1
su - dev2
```

O `-` garante que o ambiente do usuário seja carregado corretamente.

---

## 🧪 Testes de Privilégios

### Testando sudo com usuário admin

```bash
sudo whoami
```

Resultado esperado:

```bash
root
```

### Testando sudo com usuário comum

```bash
sudo whoami
```

Resultado esperado:

```bash
dev1 is not in the sudoers file
```

Isso confirma que apenas o usuário administrativo possui privilégios elevados.

---

## 🗑️ Remoção de Usuários (opcional)

Caso seja necessário remover um usuário:

```bash
sudo deluser dev2
```

Para remover também o diretório HOME:

```bash
sudo deluser --remove-home dev2
```

---

## 🧠 Boas Práticas Aprendidas

* Não usar o usuário root diretamente
* Criar um usuário administrador com `sudo`
* Manter usuários comuns sem privilégios elevados
* Usar grupos para controle de acesso
* Testar permissões após qualquer alteração

---

## ✅ Conclusão

Este estudo mostrou que o gerenciamento correto de usuários:

* Aumenta a segurança do sistema
* Facilita a organização
* Evita erros graves de permissão

Esse conhecimento é fundamental para qualquer pessoa que estuda **Linux, Infraestrutura ou DevOps**.

---