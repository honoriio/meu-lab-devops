# Permissões no Linux — Minha Jornada de Aprendizado
Este documento faz parte do meu lab pessoal de estudos em Infraestrutura e DevOps. Aqui eu registro meu aprendizado sobre permissões no Linux. Mano, esse é um dos conceitos mais importantes. Se você não manja disso, você não administra nada no Linux direito, fica tudo na base do "tentativa e erro".

Entender permissões é obrigatório pra quem quer ser Infra, DevOps ou SRE, porque no Linux quase tudo gira em torno de: quem pode fazer o quê, como e quando.

🎯 Objetivo deste estudo
O que eu foquei em aprender aqui:

Sacar como o Linux pensa na hora de liberar ou bloquear um acesso.

Aprender a ler aquela sopa de letrinhas do ls -l.

Alterar permissões do jeito certo (sem apelar pro 777).

Entender a hierarquia: Usuário vs Grupo vs Outros.

Parar de passar raiva com o erro "Permission denied" em scripts.

🧠 O conceito: No Linux, tudo é arquivo!
Uma coisa que aprendi logo de cara: no Linux, tudo é tratado como arquivo. Arquivo de texto, pasta (diretório), o seu mouse e até os processos.

Cada um desses caras tem três níveis de acesso:

Usuário (owner): O dono da criança.

Grupo (group): A "equipe" que tem acesso.

Outros (others): O resto do mundo.

E pra cada nível, existem três tipos de permissão:

r (read): Ler / Ver o conteúdo.

w (write): Escrever / Editar / Apagar.

x (execute): Rodar o script ou entrar na pasta.

👀 Visualizando a "Sopa de Letrinhas"
Pra ver como as permissões estão, o comando de guerra é o:

Bash
ls -l
Exemplo de saída que analisei:
-rwxr-xr-- 1 diego devops 4096 script.sh

Eu aprendi a quebrar esse -rwxr-xr-- assim:

O primeiro caractere (-) diz o que é: - é arquivo, d é diretório (pasta).

Os próximos três (rwx) são do Dono.

Os três do meio (r-x) são do Grupo.

Os três últimos (r--) são dos Outros.

👤👥 A "Virada de Chave": Como o acesso é validado
Essa parte foi onde as coisas realmente clicaram pra mim. O Linux não pergunta "Quem é você?", ele segue uma ordem lógica e para na primeira que der certo:

Você é o dono? Se sim, ele olha as permissões de dono e pronto.

Se não é o dono, você tá no grupo? Se sim, ele aplica o que o grupo pode fazer e para por aí.

Não é nenhum dos dois? Então você é "Outros" e só faz o que estiver no final da linha.

Regra mental que eu uso: O Linux sempre tenta te encaixar no papel mais específico primeiro.

🛠️ Comandos que usei pra mudar tudo
1. O famoso chmod (Change Mode)
Usei muito pra dar permissão de execução em scripts.

No modo simbólico (mais fácil de lembrar):

Bash
chmod u+x script.sh   # "Dono recebe (+) execução"
chmod g+w arquivo.txt # "Grupo recebe (+) escrita"
chmod o-r arquivo.txt # "Outros perdem (-) leitura"
No modo numérico (o famoso octal):
Aqui cada letra tem um valor: r=4, w=2, x=1. Você soma e pronto.

7 (4+2+1) = Acesso total.

5 (4+1) = Ler e executar.

4 = Só ler.

Bash
chmod 755 script.sh  # Dono faz tudo, o resto só lê e executa.
chmod 644 texto.txt   # Dono lê/escreve, o resto só lê.
2. Mudando o Dono com chown
Bash
# Mudar o dono
sudo chown diego arquivo.txt

# Mudar o dono e o grupo de uma vez (bem útil)
sudo chown diego:devops arquivo.txt

# Mudar uma pasta inteira e tudo dentro dela
sudo chown -R diego:devops minha_pasta/
📁 Cuidado com as Pastas (Diretórios)!
Aprendi que o x (execução) em pastas é diferente. Sem o x, você nem consegue dar um cd pra entrar nela, mesmo que tenha permissão de leitura (r). Fiquei um tempo tentando entender por que não entrava na pasta e era isso!

⚠️ Erros que cometi e quero evitar
🚨 chmod 777 em tudo: Isso é o "botão do pânico". Funciona? Sim. É seguro? Nem um pouco. É tipo deixar a chave da sua casa na fechadura pelo lado de fora.

🚨 Rodar tudo como root: Se eu erro um comando como root, eu posso apagar o sistema inteiro. Melhor usar o sudo só quando precisar.

🚨 chmod -R sem pensar: Já mudei permissão de coisa que não devia dentro de pastas do sistema e quase quebrei o boot. Tem que usar o -R (recursivo) com muita calma.

🧯 Minhas Boas Práticas
Sempre dou um ls -l antes e depois de mudar uma permissão pra conferir se não fiz besteira.

Uso grupos para gerenciar acessos de várias pessoas (mais organizado).

Tento dar sempre o mínimo de acesso necessário. Se o cara só precisa ler, pra que dar permissão de escrita?

🧠 Conclusão
Depois que você entende as permissões, o Linux deixa de ser um "bicho de sete cabeças". Erros de "Permission denied" agora são fáceis de resolver porque eu já sei onde olhar. É a base de tudo pra quem quer trabalhar com servidores e automação.

📌 Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.