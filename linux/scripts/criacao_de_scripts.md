# Criação de Scripts no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **lab pessoal de estudos em Infraestrutura e DevOps**. Aqui eu registro, com minhas próprias palavras, tudo o que estou aprendendo sobre **criação de scripts no Linux**, com foco em **Bash**, **permissões**, **execução**, **organização** e **boas práticas**.

Automação é algo central em Infra e DevOps, e os scripts são a base disso. Por isso, decidi documentar esse aprendizado de forma clara, prática e progressiva, para consolidar o conhecimento e poder consultar no futuro.

---

## 🎯 Objetivo deste estudo

Neste estudo, meu objetivo é:

* Entender claramente o que são scripts no Linux
* Aprender a criar scripts Bash do zero
* Compreender a estrutura básica de um script
* Trabalhar corretamente com permissões de execução
* Executar scripts de forma segura
* Entender variáveis, argumentos e condicionais
* Criar scripts organizados e reutilizáveis

---

## 🧠 O que é um script no Linux

Um **script no Linux** é, basicamente, um arquivo de texto que contém uma sequência de comandos que eu poderia digitar manualmente no terminal, mas que passam a ser executados de forma **automática**.

Ao usar scripts, eu consigo:

* Automatizar tarefas repetitivas
* Padronizar processos
* Reduzir erros humanos
* Ganhar produtividade
* Facilitar manutenção e auditoria

Nos ambientes Linux, a grande maioria dos scripts utiliza o **Bash (Bourne Again Shell)**, que é o shell padrão na maioria das distribuições.

---

## 📄 Criando um script

Um script começa como um **arquivo comum** no sistema.

### Criando um arquivo de script

```bash
touch meu_script.sh
```

Também posso criar o arquivo já abrindo um editor de texto:

```bash
nano meu_script.sh
# ou
vim meu_script.sh
```

A extensão `.sh` não é obrigatória, mas eu uso como **boa prática** para identificar facilmente que se trata de um script Bash.

---

## 🧱 Estrutura básica de um script Bash

Todo script Bash segue uma estrutura básica.

```bash
#!/bin/bash

# Comentários explicando o que o script faz

comando1
comando2
```

### 🔹 Shebang (`#!`)

```bash
#!/bin/bash
```

Essa linha indica qual interpretador será usado para executar o script. Sem o shebang, o sistema não sabe como interpretar o arquivo.

Uma alternativa mais portátil é:

```bash
#!/usr/bin/env bash
```

---

## ✍️ Escrevendo meu primeiro script

Exemplo de um script simples:

```bash
#!/bin/bash

echo "Olá, este é meu primeiro script!"
```

Depois de salvar o arquivo, o script já está pronto para ser executado (desde que tenha permissão).

---

## 🔐 Permissões de execução

Por padrão, arquivos criados no Linux **não vêm com permissão de execução**.

### Verificando permissões

```bash
ls -l meu_script.sh
```

Exemplo de saída:

```text
-rw-r--r-- 1 diego diego 45 meu_script.sh
```

Isso significa que o arquivo pode ser lido e editado, mas não executado.

### Tornando o script executável

```bash
chmod +x meu_script.sh
```

Após isso, as permissões ficam assim:

```text
-rwxr-xr-x 1 diego diego 45 meu_script.sh
```

---

## ▶️ Executando scripts

### Forma correta (recomendada)

```bash
./meu_script.sh
```

O `./` indica que o script está no diretório atual.

### Executando com o bash explicitamente

```bash
bash meu_script.sh
```

Nesse caso, o script é executado pelo interpretador Bash diretamente, sem precisar da permissão de execução.

---

## 📂 Organização de scripts

Para manter tudo organizado, eu sigo uma estrutura clara:

```text
scripts/
├── backup.sh
├── monitoramento.sh
├── usuarios.sh
└── rede.sh
```

Evito deixar scripts soltos na minha `$HOME`. Organização facilita manutenção e evita erros.

---

## 🧮 Variáveis

### Criando variáveis

```bash
NOME="Diego"
IDADE=27
```

### Usando variáveis

```bash
echo "Meu nome é $NOME e tenho $IDADE anos"
```

Aprendi que **não pode haver espaços** ao redor do `=`.

---

## 📥 Entrada do usuário

```bash
echo "Digite seu nome:"
read NOME
echo "Olá, $NOME"
```

---

## 📤 Argumentos de linha de comando

```bash
#!/bin/bash

echo "Primeiro argumento: $1"
echo "Segundo argumento: $2"
```

Execução:

```bash
./script.sh valor1 valor2
```

---

## 🔀 Condicionais (if)

```bash
#!/bin/bash

if [ "$USER" == "root" ]; then
  echo "Você é root"
else
  echo "Você é usuário comum"
fi
```

Aprendi que os espaços dentro do `[ ]` são obrigatórios.

---

## 🔁 Laços (loops)

### For

```bash
for i in 1 2 3 4 5; do
  echo "Número: $i"
done
```

### While

```bash
contador=1
while [ $contador -le 5 ]; do
  echo $contador
  contador=$((contador+1))
done
```

---

## 🛑 Códigos de saída

```bash
exit 0   # execução bem-sucedida
exit 1   # erro genérico
```

Verificando o código de saída:

```bash
echo $?
```

---

## 🧯 Boas práticas que estou seguindo

* Sempre usar `#!/bin/bash`
* Comentar os scripts
* Usar nomes claros e objetivos
* Evitar rodar scripts como root sem necessidade
* Testar scripts em ambiente controlado
* Usar `set -e` para interromper o script em caso de erro

```bash
set -e
```

---

## 🧠 Conclusão

Aprender Bash scripting está se mostrando uma **base essencial** para minha evolução em Infraestrutura e DevOps.

Os scripts são o primeiro passo para:

* Automação avançada
* CI/CD
* Provisionamento
* Monitoramento
* Cloud e Containers

Esse conhecimento me aproxima do nível profissional que busco na área de Infra.

---

📌 **Este documento faz parte do meu lab pessoal e será atualizado conforme eu avançar nos estudos.**
