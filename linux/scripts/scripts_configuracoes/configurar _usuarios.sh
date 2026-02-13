!/bin/bash

echo "Criando diretorios..."

mkdir -p /publico
mkdir -p /adm
mkdir -p /ven
mkdir -p /sec

echo "Criando Grupos..."

# Esse comando cria grupos de forma automatica e padronizada, e fim de evitar erros. o mesmo ja verifica se outros grupos com o mesmo nome ja foram  criados. 

for g in GRP_ADM GRP_VEN GRP_SEC; do
  getent group "$g" >/dev/null || groupadd "$g"
done


echo "Criando Usuários..."

# Esse comando permite que eu crie varios usuarios de uma vez, com seus repositorios e bash ja definido, futuramente farei algo mais iterativo e modular. 

for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  useradd -m -s /bin/bash "$u"
done

echo "Definindo senhas para usuários..."

# Esse comando criar a senha para os usuarios e expira as mesmas para que seja trocada pelo usuario no primeiro acesso. 
# esta sendo usada uma senha fraca somente para fins educacionais, na vida real seria usada politicas mais rigidas em questão de segurança.

for u in maria carlos joao debora sebastiana roberto josefina amanda rogerio; do
  echo "$u:Senha@123" | chpasswd
  passwd -e "$u"
done

echo "Direcionando os usuários para seus devidos grupos..."

usermod -aG GRP_ADM maria carlos joao
usermod -aG GRP_VEN debora sebastiana roberto
usermod -aG GRP_SEC josefina amanda rogerio

echo "Criando permissões e definindo grupos"

chown root:GRP_ADM /adm
chmod 770 /adm

chown root:GRP_VEN /ven
chmod 770 /ven

chown root:GRP_SEC /sec
chmod 770 /sec

chmod 777 /publico

echo "Configurações de usuários e grupos finalizadas..."