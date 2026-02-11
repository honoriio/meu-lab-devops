# Sistema de Arquivos no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab de estudos em Infraestrutura e DevOps** e registra meu aprendizado inicial sobre o **sistema de arquivos no Linux**.

Aqui documento, de forma prática, como aprendi a **navegar pelo sistema**, **listar arquivos**, **criar e remover diretórios** e **criar arquivos pelo terminal**.  
Esses comandos formam a base para qualquer atividade em servidores Linux, automação e ambientes de produção.

---

## 📂 Entendendo o sistema de arquivos no Linux

No Linux, tudo é organizado em forma de **árvore de diretórios**, começando pela raiz `/`.

Diferente de outros sistemas operacionais, **não existem “discos C ou D”**.  
Tudo faz parte da mesma estrutura de diretórios.

Durante meus estudos, aprendi alguns diretórios importantes:

- `/home` → diretórios dos usuários  
  - `/home` separada: permite reinstalar o sistema sem perder arquivos e configurações  
- `/etc` → arquivos de configuração do sistema  
- `/var` → logs e dados variáveis  
- `/tmp` → arquivos temporários  
- `/bin` e `/usr/bin` → comandos essenciais do sistema  

---

## 🧭 Navegação no sistema de arquivos

- `pwd` → mostra em qual diretório estou no momento  

- `cd` → muda de diretório  
- `cd /` → vai para o diretório raiz  
- `cd ~` → vai para o diretório home do usuário  
- `cd ..` → volta um nível na árvore de diretórios  
- `cd -` → volta para o último diretório acessado  

- `tree` → mostra a estrutura de diretórios em formato de árvore  

- `clear` → limpa a tela do terminal  

- `history` → mostra o histórico de comandos executados  

- `man` → exibe o manual de um comando (ex: `man ls`)  

---

## 📁 Listando arquivos e diretórios (`ls`)

- `ls` → mostra apenas o nome dos arquivos e diretórios  
- `ls -l` → mostra informações detalhadas: permissões, dono, grupo, tamanho e data  
- `ls -a` → lista todos os arquivos, incluindo os ocultos (os que começam com `.`)  
- `ls -la` → lista todos os arquivos (inclusive ocultos) em formato detalhado  
- `ls -h` → mostra os tamanhos dos arquivos em formato legível (KB, MB, GB)  
- `ls -lh` → lista arquivos em formato detalhado com tamanhos legíveis  
- `ls -R` → lista arquivos e diretórios de forma recursiva (subpastas)  
- `ls -t` → lista arquivos ordenados por data de modificação  
- `ls -S` → lista arquivos ordenados por tamanho  
- `ls -r` → inverte a ordem da listagem  
- `ls -d */` → lista apenas diretórios  
- `ls --color=auto` → lista arquivos com cores para diferenciar tipos  

---

## ⭐ Comandos mais usados no dia a dia

Durante meus estudos, esses foram os comandos que mais utilizei:

- `pwd` → mostra em qual diretório estou  
- `ls` → lista arquivos e diretórios  
- `ls -la` → lista todos os arquivos (inclusive ocultos) em formato detalhado  
- `ls -lh` → lista arquivos em formato detalhado com tamanhos legíveis  
- `ls -d */` → lista apenas diretórios  
- `ls -lt` → lista arquivos em formato detalhado ordenados por data  
- `ls -lhS` → lista arquivos em formato detalhado ordenados por tamanho  
- `ls --color=auto` → lista arquivos com cores para diferenciar tipos  
