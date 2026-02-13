# Script de Criação de Usuários, Grupos e Permissões — Minha Jornada de Aprendizado

Esse é o script que eu fiz pra automatizar **diretórios, grupos e usuários no Linux**, tudo de forma segura (pelo menos pra estudo).  
Mano, aprendi que criar tudo na mão dá pra se perder fácil, então automatizar salva muito tempo e evita erros.

---

## 🎯 Objetivo deste estudo

Com esse script, meu foco foi:

* Criar diretórios automaticamente  
* Criar grupos sem conflito de nomes  
* Criar usuários de forma rápida, com home e shell definidos  
* Associar usuários aos grupos corretos  
* Definir permissões corretas pros diretórios  
* Entender como automatizar tarefas repetitivas no Linux  

---

## 🧠 Passo a passo do script

### 1️⃣ Criando diretórios

```bash
mkdir -p /publico
mkdir -p /adm
mkdir -p /ven
mkdir -p /sec
````

> Aprendi que o `-p` evita erro se o diretório já existir.
> `/publico` é pra acesso geral, e os outros são específicos para cada grupo.

---

### 2️⃣ Criando grupos

```bash
for g in GRP_ADM GRP_VEN GRP_SEC; do
  getent group "$g" >/dev/null || groupadd "$g"
done
```

> Aqui o script checa se o grupo já existe antes de criar, assim não dá conflito.
> Mano, antes eu esquecia de fazer isso e quebrava tudo. rs

---

### 3️⃣ Criando usuários

```bash
for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  useradd -m -s /bin/bash "$u"
done
```

> `-m` cria a home do usuário, `-s /bin/bash` define o shell.
> Depois quero deixar isso mais modular, tipo ler de um arquivo e criar automaticamente.

---

### 4️⃣ Definindo senhas

```bash
for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  echo "$u:Senha@123" | chpasswd
  passwd -e "$u"
done
```

> Senhas fracas só pra estudo. Na vida real teria política séria.
> `passwd -e` força o usuário a trocar a senha no primeiro login. Bem útil pra aprendizado.

---

### 5️⃣ Associando usuários aos grupos

```bash
usermod -aG GRP_ADM maria carlos joao
usermod -aG GRP_VEN debora sebastiana roberto
usermod -aG GRP_SEC josefina amanda rogerio
```

> O `-aG` é importante pra não perder outros grupos que o usuário já tem.
> Já me ferrei esquecendo disso. 😅

---

### 6️⃣ Definindo permissões e donos dos diretórios

```bash
chown root:GRP_ADM /adm
chmod 770 /adm

chown root:GRP_VEN /ven
chmod 770 /ven

chown root:GRP_SEC /sec
chmod 770 /sec

chmod 777 /publico
```

> `/adm`, `/ven` e `/sec` → acesso total pra dono e grupo, outros não têm acesso
> `/publico` → todo mundo pode acessar, por isso 777
> Demorei pra sacar que 770 e 777 fazem diferença enorme na segurança.

---

## 🔍 Conceito que aprendi na prática

No Linux, **tudo é arquivo**: arquivos, diretórios, dispositivos e até processos.

Cada arquivo/diretório tem:

* **Dono (owner)**
* **Grupo (group)**
* **Outros (others)**

Permissões possíveis:

* `r` → ler
* `w` → escrever / editar / apagar
* `x` → executar / entrar na pasta

> Regra mental que eu uso: o Linux sempre testa o mais específico primeiro: dono → grupo → outros.

---

## 👤👥 Relação entre usuários e grupos

Todo usuário:

* Tem **um grupo primário**
* Pode estar em **vários grupos secundários**

Exemplo:

```bash
id diego
```

Saída:

```text
uid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),1001(devops)
```

* Grupo primário: `diego`
* Grupos secundários: `sudo`, `devops`

---

## 🛠️ Usando grupos e permissões

Fluxo que faz sentido pra mim:

1. Criar grupo:

```bash
sudo groupadd devops
```

2. Adicionar usuário:

```bash
sudo usermod -aG devops diego
```

3. Associar diretório ao grupo:

```bash
sudo chown :devops /srv/projetos
```

4. Definir permissões:

```bash
chmod 770 /srv/projetos
```

Resultado:

* Dono e grupo → acesso total
* Outros → sem acesso

> Esse padrão é o que mais vi em servidores e ambientes corporativos.

---

## ⚠️ Erros que já cometi

* `chmod 777` em tudo → funciona mas é perigoso
* Rodar comandos desnecessariamente como root
* `chmod -R` sem pensar → quase quebrei pastas do sistema
* Esquecer `-aG` no `usermod` → usuário perde grupo

---

## 🧯 Boas práticas que estou tentando seguir

* Sempre conferir permissões antes e depois
* Dar o mínimo de acesso necessário
* Usar grupos pra organizar usuários
* Documentar alterações
* Testar em ambiente controlado

---

## 🧠 Conclusão

Esse script **me ajudou a entender na prática** como:

* Diretórios, usuários e grupos se conectam
* Permissões funcionam de verdade
* Automatizar tarefas evita erros e salva tempo

> Agora consigo montar ambientes multiusuário de estudo de forma **segura e organizada**.

---

📌 **Este documento faz parte do meu lab pessoal e será atualizado conforme eu aprimorar o script e meus estudos.**
