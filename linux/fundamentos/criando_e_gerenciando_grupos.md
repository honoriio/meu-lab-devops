# Grupos no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab pessoal de estudos em Infraestrutura, Linux e DevOps**.  
Aqui eu registro meu aprendizado sobre **grupos no Linux**, um conceito fundamental que se conecta diretamente com permissões, segurança e ambientes multiusuário.

Depois de estudar permissões, ficou claro para mim que **grupos são o coração do controle de acesso no Linux**.  
Sem entender grupos, permissões ficam confusas e decisões de segurança acabam sendo mal feitas.

---

## 🎯 Objetivo deste estudo

Com este estudo, meu objetivo é:

- Entender o que são grupos no Linux
- Aprender a criar, remover e gerenciar grupos
- Compreender a diferença entre grupo primário e secundário
- Entender como grupos se relacionam com permissões
- Usar grupos para controlar acesso de forma correta
- Evitar erros comuns de administração e segurança

---

## 🧠 Conceito básico de grupos no Linux

Um **grupo** no Linux é uma forma de **organizar usuários** para facilitar o controle de permissões.

Em vez de dar acesso usuário por usuário, o Linux permite:
- associar arquivos e diretórios a **grupos**
- definir permissões para todos os usuários daquele grupo

Todo grupo possui:
- um **nome**
- um **GID (Group ID)**
- uma lista de **usuários membros**

As informações de grupos ficam no arquivo:

```bash
/etc/group
📂 Arquivo /etc/group
Formato padrão de uma linha:

nome_do_grupo:x:GID:usuario1,usuario2
Exemplo real:

devops:x:1001:diego,joao
Significado:

devops → nome do grupo

x → campo de senha (quase nunca usado hoje)

1001 → GID do grupo

diego,joao → usuários membros do grupo

🔍 Listando grupos
Listar todos os grupos do sistema
getent group
Listar apenas grupos criados para usuários (GID ≥ 1000)
awk -F: '$3 >= 1000 {print $1 ":" $3}' /etc/group
Ver os grupos de um usuário
groups diego
Ou de forma mais completa:

id diego
👤👥 Grupo primário vs grupos secundários
Todo usuário no Linux:

Possui um grupo primário

Pode pertencer a vários grupos secundários

Exemplo:

id diego
Saída:

uid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),1001(devops)
Isso significa:

Grupo primário: diego

Grupos secundários: sudo, devops

📌 O grupo primário:

é definido na criação do usuário

é usado automaticamente nos arquivos que o usuário cria

➕ Criando grupos
Criar um grupo simples:

sudo groupadd devops
Criar um grupo com GID específico:

sudo groupadd -g 1500 devops
Normalmente não preciso definir GID manualmente, deixo o sistema gerenciar isso.

👥 Adicionando usuários a grupos
Forma correta (sem remover outros grupos):

sudo usermod -aG devops usuario
Exemplo:

sudo usermod -aG devops diego
⚠️ Aprendi que nunca devo esquecer o -a, senão o usuário perde os outros grupos.

➖ Removendo usuário de um grupo
sudo gpasswd -d usuario grupo
Exemplo:

sudo gpasswd -d diego devops
❌ Removendo grupos
Para remover um grupo:

sudo groupdel nome_do_grupo
⚠️ Importante:

Um grupo não pode ser removido se for o grupo primário de algum usuário

Para verificar quem usa um grupo como primário:

grep nome_do_grupo /etc/passwd
Se aparecer alguém, preciso alterar o grupo primário antes.

📂 Grupos associados a arquivos
Todo arquivo ou diretório no Linux possui:

um dono (usuário)

um grupo

permissões associadas a ambos

Exemplo:

-rw-r----- 1 diego devops 1024 arquivo.txt
Aqui:

Dono: diego

Grupo: devops

Isso significa:

Qualquer usuário que pertença ao grupo devops

Terá acesso conforme as permissões do bloco de grupo

🛠️ Alterando grupo de arquivos
Alterar apenas o grupo:

chgrp devops arquivo.txt
Ou usando chown:

chown :devops arquivo.txt
Alterar recursivamente:

chown -R :devops diretorio/
🔐 Usando grupos para controle de acesso (na prática)
Fluxo que faz sentido para mim:

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

Esse padrão é muito usado em servidores e ambientes corporativos.

🚨 Grupos críticos (NUNCA remover)
Durante meus estudos aprendi que alguns grupos são essenciais para o sistema:

root

sudo

adm

wheel (Fedora / Arch)

daemon

sys

systemd-*

Remover esses grupos pode quebrar o sistema.

⚠️ Erros comuns que aprendi a evitar
Criar grupos sem necessidade

Remover grupos sem verificar usuários associados

Confundir grupo primário com secundário

Usar permissões abertas para compensar erro de grupo

Administrar tudo como root

🧯 Boas práticas que estou seguindo
Usar grupos para controlar acesso

Manter permissões restritas

Conferir grupos com id antes e depois de mudanças

Documentar alterações importantes

Testar em ambiente controlado

🧠 Conclusão
Depois que entendi grupos, permissões fizeram sentido de verdade.

Grupos são a ponte entre:

usuários

arquivos

permissões

segurança

Dominar grupos é essencial para:

administração de sistemas

ambientes multiusuário

servidores Linux

Infraestrutura, DevOps e SRE

📌 Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.

