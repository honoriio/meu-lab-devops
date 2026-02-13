# Script de Criação de Usuários e Grupos — Minha Jornada de Aprendizado

Esse é um script que eu fiz pra automatizar a **criação de diretórios, grupos e usuários no Linux**, tudo de forma padronizada e segura (ao menos para estudos).  
Mano, eu aprendi que scripts assim salvam muita dor de cabeça, porque criar tudo na mão dá pra quebrar a cabeça fácil.

---

## 🎯 Objetivo deste estudo

O que eu quis aprender e testar com esse script:

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
Aprendi que o -p evita erro se o diretório já existir.
/publico é pra acesso geral, e os outros são pra grupos específicos.

2️⃣ Criando grupos
for g in GRP_ADM GRP_VEN GRP_SEC; do
  getent group "$g" >/dev/null || groupadd "$g"
done
Aqui eu usei uma checagem pra não criar grupo repetido.
Mano, antes eu esquecia de checar e quebrava o script. Agora tá seguro. rs

3️⃣ Criando usuários
for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  useradd -m -s /bin/bash "$u"
done
-m cria a home do usuário, -s /bin/bash define o shell.
No futuro quero deixar isso mais modular, tipo ler nomes de um arquivo e criar automático.

4️⃣ Definindo senhas
for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  echo "$u:Senha@123" | chpasswd
  passwd -e "$u"
done
Criei senhas fracas só pra estudo, porque no mundo real tem que ter política de segurança séria.
passwd -e força o usuário a trocar a senha no primeiro login.

5️⃣ Associando usuários aos grupos
usermod -aG GRP_ADM maria carlos joao
usermod -aG GRP_VEN debora sebastiana roberto
usermod -aG GRP_SEC josefina amanda rogerio
O -aG é importante pra não perder outros grupos do usuário, já me ferrei antes esquecendo isso. 😅

6️⃣ Definindo permissões e donos dos diretórios
chown root:GRP_ADM /adm
chmod 770 /adm

chown root:GRP_VEN /ven
chmod 770 /ven

chown root:GRP_SEC /sec
chmod 770 /sec

chmod 777 /publico
/adm, /ven e /sec → acesso completo pra dono e grupo, ninguém mais
/publico → todo mundo pode acessar, por isso 777

⚠️ Observações importantes que aprendi
Sempre checar se grupo/usuário já existe antes de criar

chmod 770 protege diretórios de acessos indesejados

-aG no usermod evita perder grupos

Senhas fracas só pra testes educacionais

🧯 Boas práticas que estou tentando seguir
Automatizar tarefas repetitivas pra evitar erro humano

Padronizar nomes de grupos e usuários

Separar diretórios por grupo pra facilitar controle de acesso

Documentar cada passo no script

🧠 Conclusão
Esse script me ajudou a entender na prática como grupos, usuários e permissões trabalham juntos no Linux.
Mano, automatizar faz tudo ficar mais rápido, seguro e fácil de manter.
Aprendi muito sobre useradd, groupadd, usermod, chmod e chown, e agora consigo montar ambientes multiusuário de estudo de forma segura.

📌 Este documento faz parte do meu lab pessoal e será atualizado conforme eu aprimorar o script e meus estudos.