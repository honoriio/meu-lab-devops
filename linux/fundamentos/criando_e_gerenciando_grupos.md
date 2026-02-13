# Grupos no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab pessoal de estudos em Infraestrutura e DevOps**. Aqui eu registro meu aprendizado sobre **grupos no Linux**, um conceito fundamental que conecta diretamente com permissões, segurança e ambientes multiusuário.  
Mano, percebi que sem entender grupos, as permissões ficam confusas e qualquer decisão de segurança pode sair pela culatra.  

---

## 🎯 Objetivo deste estudo

O que eu foquei em aprender aqui:

* Entender o que são grupos no Linux  
* Aprender a criar, remover e gerenciar grupos  
* Compreender a diferença entre grupo primário e secundário  
* Entender como grupos se relacionam com permissões  
* Evitar erros comuns de administração e segurança  
* Aplicar grupos de forma prática em diretórios e arquivos  

---

## 🧠 Conceito básico de grupos

Um **grupo** no Linux é uma forma de **organizar usuários** pra facilitar o controle de acesso.  

Ao invés de dar permissão usuário por usuário, você pode:

* Associar arquivos e diretórios a grupos  
* Definir permissões pra todo mundo do grupo  

Todo grupo possui:

* Um **nome**  
* Um **GID (Group ID)**  
* Uma lista de **usuários membros**  

As informações ficam no arquivo `/etc/group`.

### 📂 Arquivo `/etc/group`

Formato de uma linha:

```text
nome_do_grupo:x:GID:usuario1,usuario2
Exemplo que testei:

devops:x:1001:diego,joao
Significado:

devops → nome do grupo

x → campo de senha (quase nunca usado)

1001 → GID do grupo

diego,joao → usuários membros do grupo

Demorei pra sacar isso no começo, mas agora faz muito sentido rs.

🔍 Listando grupos
Todos os grupos do sistema:

getent group
Apenas grupos de usuários comuns (GID ≥ 1000):

awk -F: '$3 >= 1000 {print $1 ":" $3}' /etc/group
Ver grupos de um usuário:

groups diego
Mais completo:

id diego
👤👥 Grupo primário vs secundários
Todo usuário:

Possui um grupo primário

Pode pertencer a vários grupos secundários

Exemplo:

id diego
Saída típica:

uid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),1001(devops)
Isso significa:

Primário: diego

Secundários: sudo, devops

📌 O grupo primário é definido na criação do usuário e usado automaticamente nos arquivos que ele cria.

➕ Criando grupos
Grupo simples:

sudo groupadd devops
Grupo com GID específico:

sudo groupadd -g 1500 devops
Normalmente deixo o sistema escolher o GID, mas às vezes é útil definir manualmente.

👥 Adicionando usuários a grupos
Forma correta (sem remover outros grupos):

sudo usermod -aG devops usuario
Exemplo que testei:

sudo usermod -aG devops diego
⚠️ Não esquecer o -a, senão o usuário perde os outros grupos que já tinha — aprendi na marra rs.

➖ Removendo usuário de um grupo
sudo gpasswd -d usuario grupo
Exemplo:

sudo gpasswd -d diego devops
❌ Removendo grupos
sudo groupdel nome_do_grupo
⚠️ Um grupo não pode ser removido se for primário de algum usuário.
Pra checar:

grep nome_do_grupo /etc/passwd
Se aparecer alguém, preciso mudar o grupo primário antes.

📂 Grupos e arquivos
Todo arquivo/diretório possui:

Um dono (usuário)

Um grupo

Permissões associadas a ambos

Exemplo:

-rw-r----- 1 diego devops 1024 arquivo.txt
Aqui:

Dono: diego

Grupo: devops

Qualquer usuário do grupo devops terá acesso conforme as permissões do grupo.

🛠️ Alterando grupo de arquivos
Apenas o grupo:

chgrp devops arquivo.txt
Usando chown:

chown :devops arquivo.txt
Recursivamente:

chown -R :devops diretorio/
🔐 Controle de acesso prático
Fluxo que uso nos testes:

Criar grupo:

sudo groupadd devops
Adicionar usuários:

sudo usermod -aG devops usuario
Associar diretório ao grupo:

sudo chown :devops /srv/projetos
Definir permissões:

chmod 770 /srv/projetos
Resultado:

Dono e grupo → acesso total

Outros → sem acesso

Achei esse padrão muito útil, padrão de servidor corporativo.

🚨 Grupos críticos (NUNCA remover)
root

sudo

adm

wheel (Fedora / Arch)

daemon

sys

systemd-*

Remover esses grupos quebra o sistema, já quebrei a cabeça com isso antes rs.

⚠️ Erros comuns que aprendi a evitar
Criar grupos sem necessidade

Remover grupos sem checar usuários

Confundir primário e secundário

Usar permissões abertas pra “consertar” erro

Administrar tudo como root

🧯 Boas práticas que estou seguindo
Usar grupos pra controlar acesso

Manter permissões restritas

Conferir grupos com id antes e depois de mudanças

Documentar alterações importantes

Testar em ambiente controlado

🧠 Conclusão
Depois que entendi grupos, permissões e acesso fizeram sentido de verdade.

Grupos conectam:

Usuários

Arquivos

Permissões

Segurança

Dominar grupos é essencial pra:

Administração de sistemas

Ambientes multiusuário

Servidores Linux

Infraestrutura, DevOps e SRE

📌 Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.