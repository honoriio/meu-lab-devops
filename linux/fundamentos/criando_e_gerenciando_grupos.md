# Permissões e Grupos no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab pessoal de estudos em Infraestrutura e DevOps**. Aqui eu registro meu aprendizado sobre **permissões e grupos no Linux**, dois conceitos fundamentais pra administrar sistemas, segurança e automação.  
Mano, esses tópicos são cruciais: se você não manja disso, você não controla nada direito no Linux, fica tudo na base do “tentativa e erro”.

---

## 🎯 Objetivo deste estudo

O que eu foquei em aprender aqui:

* Entender como funcionam permissões e grupos no Linux  
* Aprender a ler permissões de arquivos e diretórios  
* Saber criar, alterar e remover grupos  
* Compreender usuários, grupos, dono (owner) e outros níveis de acesso  
* Evitar erros comuns de segurança  
* Aplicar permissões e grupos de forma prática em scripts e sistemas  

---

## 🧠 Conceito básico de permissões

No Linux, **tudo é tratado como arquivo** — arquivos comuns, diretórios, dispositivos e até processos.

Cada arquivo/diretório possui **três níveis de permissão**:

1. **Usuário (owner)** — dono do arquivo  
2. **Grupo (group)** — grupo associado ao arquivo  
3. **Outros (others)** — todos os demais usuários  

E três tipos de permissão:

* **r (read)** — leitura  
* **w (write)** — escrita  
* **x (execute)** — execução  

---

## 👀 Visualizando permissões

Pra ver permissões, o comando que mais usei foi:

```bash
ls -l
````

Exemplo:

```text
-rwxr-xr-- 1 diego devops 4096 script.sh
```

---

## 🔍 Entendendo a saída do ls -l

Quebro assim:

* `-` → tipo de arquivo (arquivo comum)
* `rwx` → permissões do usuário (owner)
* `r-x` → permissões do grupo
* `r--` → permissões de outros

Tipos de arquivo mais comuns:

* `-` arquivo comum
* `d` diretório
* `l` link simbólico

---

## 👤👥 Como permissões se ligam a usuários e grupos

O Linux **não dá permissão diretamente pra usuários individuais**. Ele avalia em ordem:

1. Você é o **dono** do arquivo? → aplica permissão do dono
2. Se não, você tá no **grupo** do arquivo? → aplica permissão do grupo
3. Se não, você é **outros (others)** → aplica permissão final

> Regra mental que eu uso: o Linux sempre tenta te encaixar no papel mais específico primeiro.

---

## 🔧 Alterando permissões — chmod

### Modo simbólico

```bash
chmod u+x arquivo.sh   # adiciona execução ao usuário
chmod g+w arquivo.txt  # adiciona escrita ao grupo
chmod o-r arquivo.txt  # remove leitura de outros
```

### Modo numérico (octal)

Valores: r=4, w=2, x=1

```bash
chmod 755 script.sh   # dono faz tudo, grupo/others lê e executa
chmod 644 arquivo.txt  # dono lê/escreve, grupo/others só lê
```

---

## 👤 Alterando dono e grupo — chown

```bash
# mudar dono
sudo chown diego arquivo.txt

# mudar dono e grupo
sudo chown diego:devops arquivo.txt

# mudar recursivamente
sudo chown -R diego:devops minha_pasta/
```

---

## 👥 Alterando grupo — chgrp

```bash
chgrp devops arquivo.txt
```

> Útil quando só preciso mudar o grupo, sem alterar dono.

---

## 🔁 Permissões recursivas

```bash
chmod -R 755 diretorio/
```

⚠️ Cuidado: alterar recursivamente pode quebrar coisas importantes.

---

## 🔐 Permissões e scripts

Para executar um script:

* O arquivo precisa de permissão `x`
* O usuário precisa ter direito de execução

```bash
chmod +x script.sh
./script.sh
```

Sem permissão:

```text
Permission denied
```

---

## 🧠 Conceito básico de grupos

Um **grupo** organiza usuários pra controlar acesso coletivo a arquivos/diretórios.

Ao invés de dar acesso usuário por usuário, você pode:

* Associar arquivos/diretórios a grupos
* Definir permissões pro grupo

Todo grupo possui:

* Nome
* GID (Group ID)
* Lista de membros

Informações ficam em `/etc/group`.

### 📂 Arquivo `/etc/group`

Formato:

```text
nome_do_grupo:x:GID:usuario1,usuario2
```

Exemplo:

```text
devops:x:1001:diego,joao
```

---

## 🔍 Listando grupos

* Todos os grupos:

```bash
getent group
```

* Apenas grupos de usuários (GID ≥ 1000):

```bash
awk -F: '$3 >= 1000 {print $1 ":" $3}' /etc/group
```

* Grupos de um usuário:

```bash
groups diego
```

* Mais completo:

```bash
id diego
```

---

## 👤👥 Grupo primário vs secundários

Todo usuário:

* Tem **grupo primário**
* Pode ter **vários grupos secundários**

Exemplo:

```bash
id diego
```

Saída:

```text
uid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),1001(devops)
```

Primário: `diego`
Secundários: `sudo`, `devops`

---

### ➕ Criando grupos

```bash
sudo groupadd devops           # simples
sudo groupadd -g 1500 devops   # com GID específico
```

> Geralmente deixo o sistema escolher o GID, mas às vezes é útil definir manualmente.

---

### 👥 Adicionando usuários a grupos

```bash
sudo usermod -aG devops diego
```

⚠️ Não esquecer o `-a`, senão perde outros grupos.

---

### ➖ Removendo usuário de um grupo

```bash
sudo gpasswd -d diego devops
```

---

### ❌ Removendo grupos

```bash
sudo groupdel devops
```

⚠️ Um grupo não pode ser removido se for primário de algum usuário.
Checar:

```bash
grep devops /etc/passwd
```

---

## 📂 Grupos e arquivos

Exemplo de arquivo:

```text
-rw-r----- 1 diego devops 1024 arquivo.txt
```

* Dono: `diego`
* Grupo: `devops`

> Qualquer usuário do grupo `devops` terá acesso conforme as permissões do bloco de grupo.

---

### 🛠️ Alterando grupo de arquivos

```bash
chgrp devops arquivo.txt
chown :devops arquivo.txt
chown -R :devops diretorio/
```

---

### 🔐 Controle de acesso prático

Fluxo que uso:

```bash
sudo groupadd devops
sudo usermod -aG devops diego
sudo chown :devops /srv/projetos
chmod 770 /srv/projetos
```

Resultado:

* Dono e grupo → acesso total
* Outros → sem acesso

---

## 🚨 Grupos críticos (NUNCA remover)

* root
* sudo
* adm
* wheel (Fedora/Arch)
* daemon
* sys
* systemd-*

> Remover esses grupos quebra o sistema, já quebrei a cabeça com isso antes rs.

---

## ⚠️ Erros comuns que aprendi a evitar

* Criar grupos sem necessidade
* Remover grupos sem checar usuários
* Confundir primário e secundário
* Usar permissões abertas pra “consertar” erro
* Administrar tudo como root
* chmod 777 indiscriminadamente

---

## 🧯 Boas práticas que estou seguindo

* Conferir permissões e grupos antes/depois
* Dar mínimo acesso necessário
* Usar grupos pra organizar usuários
* Testar mudanças em ambiente controlado
* Documentar tudo

---

## 🧠 Conclusão

Depois que entendi **permissões e grupos**, muita coisa fez sentido.
Erros de "Permission denied" e problemas de acesso agora são fáceis de resolver.

Dominar isso é essencial pra:

* Administração de sistemas
* Segurança
* Execução de scripts
* Ambientes multiusuário
* Infraestrutura, DevOps e SRE

---

📌 **Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.**