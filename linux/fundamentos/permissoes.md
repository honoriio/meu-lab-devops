# Permissões no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab pessoal de estudos em Infraestrutura e DevOps**. Aqui eu registro meu aprendizado sobre **perissões no Linux**, um dos conceitos mais importantes para administração de sistemas, segurança e automação.

Entender permissões é obrigatório para quem trabalha com **Infra**, **DevOps** ou **SRE**, porque praticamente tudo no Linux gira em torno de **quem pode acessar o quê, como e quando**.

---

## 🎯 Objetivo deste estudo

Com este estudo, meu objetivo é:

* Entender como funcionam permissões no Linux
* Aprender a ler permissões de arquivos e diretórios
* Saber alterar permissões corretamente
* Compreender usuários, grupos e dono (owner)
* Evitar erros comuns de segurança
* Aplicar permissões de forma consciente em scripts e sistemas

---

## 🧠 Conceito básico de permissões

No Linux, **tudo é tratado como arquivo** — arquivos comuns, diretórios, dispositivos e até processos.

Cada arquivo ou diretório possui **três níveis de permissão**:

1. **Usuário (owner)** — dono do arquivo
2. **Grupo (group)** — grupo associado ao arquivo
3. **Outros (others)** — todos os demais usuários

E três tipos de permissão:

* **r (read)** — leitura
* **w (write)** — escrita
* **x (execute)** — execução

---

## 👀 Visualizando permissões

Para ver permissões, utilizo:

```bash
ls -l
```

Exemplo de saída:

```text
-rwxr-xr-- 1 diego devops 4096 script.sh
```

---

## 🔍 Entendendo a saída do ls -l

```text
-rwxr-xr--
```

Quebro isso da seguinte forma:

* `-` → tipo de arquivo (arquivo comum)
* `rwx` → permissões do usuário (owner)
* `r-x` → permissões do grupo
* `r--` → permissões de outros

Tipos de arquivo mais comuns:

* `-` arquivo comum
* `d` diretório
* `l` link simbólico

---

## 👤👥 Como permissões se ligam a usuários e grupos (parte essencial)

Aqui foi onde as coisas realmente **clicaram** para mim.

No Linux, **permissões não são dadas diretamente para usuários individuais**, e sim através de:

* **Dono do arquivo (owner)**
* **Grupo associado ao arquivo**
* **Outros usuários**

Ou seja: o sistema **sempre avalia o acesso nessa ordem**:

1. O usuário é o **dono** do arquivo?
2. Se não for, ele faz parte do **grupo** do arquivo?
3. Se não for, ele cai na regra de **outros (others)**

O Linux **para na primeira regra que casar**.

---

### 🔗 Relação entre usuário e arquivo

Todo arquivo possui **um único dono**.

Posso ver isso com:

```bash
ls -l arquivo.txt
```

Exemplo:

```text
-rw-r----- 1 diego devops 1024 arquivo.txt
```

Aqui:

* `diego` → é o **usuário dono** do arquivo
* As permissões `rw-` se aplicam **somente a ele**

Se eu estiver logado como `diego`, o sistema usa **essas permissões**.

---

### 👥 Como funcionam os grupos no Linux

Todo usuário no Linux:

* Possui **um grupo primário**
* Pode pertencer a **vários grupos secundários**

Vejo isso com:

```bash
id diego
```

Ou apenas:

```bash
id
```

Exemplo:

```text
uid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),100(devops)
```

Isso significa:

* Grupo primário: `diego`
* Grupos adicionais: `sudo`, `devops`

---

### 📂 Grupo associado ao arquivo

Todo arquivo tem **apenas um grupo associado**.

No exemplo:

```text
-rw-r----- 1 diego devops 1024 arquivo.txt
```

O grupo do arquivo é `devops`.

Isso significa:

* Qualquer usuário que pertença ao grupo `devops`
* Terá acesso conforme as permissões do **bloco de grupo** (`r--`)

Esse é o mecanismo **mais usado para controle de acesso em ambientes multiusuário**.

---

### 🧠 Regra mental que eu uso

Quando um usuário tenta acessar um arquivo, penso assim:

> “O Linux não pergunta *quem você é*, ele pergunta *em qual papel você se encaixa*.”

* Se for dono → usa permissões do dono
* Se não, mas estiver no grupo → usa permissões do grupo
* Se não → usa permissões de outros

---

### 🛠️ Usando grupos para controlar acesso (na prática)

Criar um grupo:

```bash
sudo groupadd devops
```

Adicionar usuários ao grupo:

```bash
sudo usermod -aG devops usuario
```

Associar diretório ao grupo:

```bash
sudo chown :devops /srv/projetos
```

Definir permissões:

```bash
chmod 770 /srv/projetos
```

Resultado:

* Dono e grupo → acesso total
* Outros → sem acesso

---

## 📁 Permissões em diretórios (importante)

Em diretórios, as permissões têm um significado específico:

* **r** → listar arquivos (`ls`)
* **w** → criar, apagar ou renomear arquivos
* **x** → acessar o diretório (`cd`)

Sem a permissão `x`, não é possível entrar no diretório, mesmo com `r`.

---

## 🔧 Alterando permissões — chmod

O comando principal para alterar permissões é o `chmod`.

### Modo simbólico

```bash
chmod u+x arquivo.sh   # adiciona execução ao usuário
chmod g+w arquivo.txt  # adiciona escrita ao grupo
chmod o-r arquivo.txt  # remove leitura de outros
```

Onde:

* `u` → usuário
* `g` → grupo
* `o` → outros
* `a` → todos

---

### Modo numérico (octal)

Cada permissão possui um valor:

* r = 4
* w = 2
* x = 1

Exemplos:

```bash
chmod 755 script.sh
chmod 644 arquivo.txt
```

Interpretação:

* **755** → dono: rwx | grupo: r-x | outros: r-x
* **644** → dono: rw- | grupo: r-- | outros: r--

---

## 👤 Alterando dono e grupo — chown

Para alterar o dono de um arquivo:

```bash
chown usuario arquivo.txt
```

Para alterar dono e grupo:

```bash
chown usuario:grupo arquivo.txt
```

Alterar recursivamente:

```bash
chown -R usuario:grupo diretorio/
```

---

## 👥 Alterando grupo — chgrp

```bash
chgrp grupo arquivo.txt
```

Uso isso quando preciso apenas ajustar o grupo sem alterar o dono.

---

## 🔁 Permissões recursivas

Para aplicar permissões em diretórios e arquivos internos:

```bash
chmod -R 755 diretorio/
```

⚠️ Uso com cuidado, pois pode quebrar permissões importantes.

---

## 🔐 Permissões e scripts

Para executar um script:

* O arquivo precisa ter permissão `x`
* O usuário precisa ter direito de execução

Exemplo:

```bash
chmod +x script.sh
./script.sh
```

Sem permissão:

```text
Permission denied
```

---

## ⚠️ Erros comuns que aprendi a evitar

* Usar `chmod 777` indiscriminadamente
* Rodar tudo como root
* Quebrar permissões do sistema com `chmod -R /`
* Não entender permissões antes de alterá-las

---

## 🧯 Boas práticas que estou seguindo

* Sempre verificar permissões antes de alterar
* Dar o mínimo de acesso necessário
* Usar grupos para controlar acesso
* Evitar permissões abertas
* Testar mudanças em ambiente controlado

---

## 🧠 Conclusão

Permissões são um dos pilares do Linux. Depois que comecei a entender como elas funcionam, muita coisa fez mais sentido: erros de acesso, falhas de execução, problemas de segurança.

Dominar permissões é essencial para:

* Administração de sistemas
* Segurança
* Execução de scripts
* Ambientes multiusuário
* Infraestrutura e DevOps

---

📌 **Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.**

