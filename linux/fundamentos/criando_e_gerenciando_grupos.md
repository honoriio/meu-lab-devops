Grupos no Linux — Minha Jornada de Aprendizado
Esse documento faz parte do meu lab pessoal de estudos em Infraestrutura, Linux e DevOps.
Aqui eu tô registrando tudo que tô aprendendo sobre grupos no Linux, porque depois de bater a cabeça um tempão com permissões, ficou claro pra mim que grupos são o verdadeiro coração do controle de acesso. Sem entender isso direito, as permissões viram uma bagunça e a gente acaba tomando decisão de segurança que dá medo.

🎯 Objetivo deste estudo
Meu objetivo com esse estudo é bem simples:

Entender de verdade o que é um grupo no Linux
Aprender a criar, gerenciar e remover grupos sem quebrar nada
Sacar a diferença entre grupo primário e secundário (demorei pra isso, hein)
Ver como os grupos se conectam com as permissões de arquivos
Usar grupos pra controlar acesso de forma inteligente e segura
Evitar os erros clássicos que todo mundo (inclusive eu) comete no começo


🧠 Conceito básico de grupos no Linux
Eu entendi que grupo no Linux é basicamente uma forma de juntar usuários que precisam do mesmo tipo de acesso. Em vez de ficar dando permissão um por um (o que é um pesadelo), a gente associa arquivos e pastas a um grupo e define as regras pra todo mundo de uma vez.
Todo grupo tem:

Um nome (tipo devops)
Um GID (Group ID, que é tipo o "CPF" do grupo)
Uma lista de usuários que fazem parte dele

Todas essas informações ficam guardadas no arquivo /etc/group. Eu dei uma olhada nele e é bem simples:
Formato de cada linha:
textnome_do_grupo:x:GID:usuario1,usuario2
Exemplo real que eu vi no meu sistema:
textdevops:x:1001:diego,joao,marina

devops → nome do grupo
x → senha (quase nunca usado hoje em dia)
1001 → GID
diego,joao,marina → os caras que fazem parte


🔍 Listando grupos (comandos que eu uso o tempo todo)
Bash# Ver todos os grupos do sistema
getent group

# Só os grupos "normais" (GID maior ou igual a 1000)
awk -F: '$3 >= 1000 {print $1 ":" $3}' /etc/group

# Grupos de um usuário específico
groups diego

# Mais completo (uid, gid e todos os grupos)
id diego
A saída do id diego fica mais ou menos assim:
textuid=1000(diego) gid=1000(diego) groups=1000(diego),27(sudo),1001(devops)

👤👥 Grupo primário vs grupos secundários
Todo usuário tem um grupo primário (obrigatório) e pode ter vários grupos secundários.
Eu testei isso e entendi assim:

O primário é o que o usuário ganha quando é criado e é o grupo que os arquivos novos dele recebem automaticamente.
Os secundários são os "extras" (tipo sudo, docker, devops...).

No exemplo acima:

Grupo primário: diego (gid 1000)
Secundários: sudo e devops

Dica que eu aprendi na marra: o primário é definido na hora de criar o usuário e é usado pra tudo que ele cria. Os secundários são pra dar acesso extra.

🛠️ Criando e gerenciando grupos
Criando um grupo
Bash# O jeito mais simples (o sistema escolhe o GID)
sudo groupadd devops

# Se eu quiser definir o GID na mão (quase nunca preciso)
sudo groupadd -g 1500 devops
Eu costumo deixar o sistema escolher, fica mais fácil.
Adicionando usuário em grupo (CUIDADO MÁXIMO AQUI)
Bash# Jeito CERTO (mantém todos os outros grupos)
sudo usermod -aG devops diego

# Jeito ERRADO (que eu já fiz e me arrependi)
sudo usermod -G devops diego   # ← isso apaga todos os outros grupos! rs
Lição aprendida: nunca esquece o -a (append). Eu já ferrei um usuário uma vez e tive que recriar os grupos dele.
Removendo usuário de um grupo
Bashsudo gpasswd -d diego devops
Apagando um grupo
Bashsudo groupdel devops
Atenção importante:
Não dá pra apagar um grupo se ele for primário de alguém. Eu verifico antes assim:
Bashgrep devops /etc/passwd
Se aparecer alguém, mudo o primário primeiro com usermod -g.

📂 Grupos e arquivos (onde a mágica acontece)
Todo arquivo tem dono, grupo e permissões. Exemplo que eu vejo bastante:
text-rw-r-----  1 diego  devops  1024  jan 15  arquivo.txt
Significa:

diego (dono) → pode ler e escrever
quem tá no grupo devops → pode ler
outros → nada

Mudando o grupo de arquivos
Bash# Só muda o grupo
chgrp devops arquivo.txt

# Ou usando chown (eu uso mais esse)
chown :devops arquivo.txt

# Em pasta inteira (recursivo)
chown -R :devops /srv/projetos/

🔐 Exemplo prático que eu uso em servidor
Esse fluxo eu testei e ficou show:
Bash# 1. Crio o grupo
sudo groupadd devops

# 2. Adiciono a galera
sudo usermod -aG devops diego
sudo usermod -aG devops joao
sudo usermod -aG devops marina

# 3. Mudo o grupo da pasta
sudo chown -R :devops /srv/projetos

# 4. Permissões certas
sudo chmod -R 770 /srv/projetos
Resultado: só quem tá no grupo devops consegue mexer. Perfeito pra projeto em equipe.

🚨 Grupos que eu NUNCA mexo
Aprendi que tem grupos do sistema que são sagrados:

root
sudo (ou wheel em Fedora/Arch)
adm
daemon
sys
systemd-*

Se eu apagar algum desses, o sistema vira um caos. Melhor nem arriscar.

⚠️ Erros comuns que eu já cometi (e que você provavelmente vai cometer)

Esquecer o -a no usermod e perder todos os grupos (já aconteceu)
Criar grupo pra tudo e depois não lembrar pra que serve
Dar 777 porque "não funcionou com grupo" (nunca mais)
Remover grupo sem checar o /etc/passwd
Fazer tudo como root (aí grupo vira inútil)


🧯 Boas práticas que tô tentando seguir

Usar grupos pra dar acesso em vez de permissões abertas
Sempre rodar id usuario antes e depois de mudar
Documentar quem tá em qual grupo (principalmente em servidor)
Testar tudo em VM antes de mexer em produção
Preferir 770 ou 750 em pastas compartilhadas
Dar nomes claros pros grupos (ex: equipe_web, time_backup)


🧠 O que eu tirei disso até agora
Depois que cliquei no lance dos grupos, as permissões finalmente fizeram sentido pra mim. Eles são tipo a ponte entre usuários, arquivos, permissões e segurança.
Dominar isso é essencial pra:

Administração de sistemas
Ambientes multiusuário
Servidores Linux de verdade
Tudo que envolve DevOps e SRE

📌 Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.