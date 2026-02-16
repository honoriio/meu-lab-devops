# Gerenciamento de Pacotes no Linux — `apt` e `apt-get`
## Minha Jornada de Aprendizado

Este documento faz parte do meu **estudo prático sobre Linux**, mais especificamente sobre **gerenciamento de pacotes em distribuições baseadas em Debian**, como Ubuntu.

Aqui eu registro o que aprendi sobre os comandos **`apt-get`** e **`apt`**, suas diferenças, objetivos e quando utilizar cada um.

---

## 📦 O que é o APT?

O **APT (Advanced Package Tool)** é um sistema de gerenciamento de pacotes usado em distribuições baseadas no Debian.

Ele é responsável por:
- Instalar programas
- Remover programas
- Atualizar pacotes
- Resolver dependências automaticamente
- Manter o sistema atualizado e organizado

Os comandos `apt-get` e `apt` são **interfaces diferentes** para esse mesmo sistema.

---

## 🔹 `apt-get`

### O que é
O `apt-get` é o **comando clássico e mais antigo** do APT.  
Ele foi criado pensando em **scripts, automações e estabilidade**.

Seu comportamento e saída são **consistentes ao longo do tempo**, o que o torna ideal para ambientes de produção.

---

### 📌 Principais comandos do `apt-get`

#### Atualizar lista de pacotes
```bash
sudo apt-get update
````

Atualiza a lista de pacotes disponíveis nos repositórios.

---

#### Atualizar pacotes instalados

```bash
sudo apt-get upgrade
```

Atualiza os pacotes instalados **sem remover ou instalar novos pacotes automaticamente**.

---

#### Atualização completa (mais agressiva)

```bash
sudo apt-get dist-upgrade
```

Atualiza pacotes **permitindo remover ou instalar dependências**, se necessário.

---

#### Instalar pacotes

```bash
sudo apt-get install nome_do_pacote
```

---

#### Remover pacotes (mantém arquivos de configuração)

```bash
sudo apt-get remove nome_do_pacote
```

---

#### Remover pacotes + arquivos de configuração

```bash
sudo apt-get purge nome_do_pacote
```

---

#### Remover dependências não usadas

```bash
sudo apt-get autoremove
```

---

#### Limpar cache de pacotes baixados

```bash
sudo apt-get clean
```

---

#### Limpar cache parcial

```bash
sudo apt-get autoclean
```

---

#### Simular ações (sem executar)

```bash
sudo apt-get install nome_do_pacote --simulate
```

---

## 🔹 `apt`

### O que é

O `apt` é uma **interface mais moderna**, criada para facilitar o uso humano no terminal.

Ele **combina funcionalidades** do:

* `apt-get`
* `apt-cache`

E apresenta:

* Saída mais limpa
* Barras de progresso
* Mensagens mais legíveis

⚠️ **Não é recomendado para scripts**, pois o formato da saída pode mudar.

---

### 📌 Principais comandos do `apt`

#### Atualizar lista de pacotes

```bash
sudo apt update
```

---

#### Atualizar pacotes instalados

```bash
sudo apt upgrade
```

---

#### Atualização completa

```bash
sudo apt full-upgrade
```

Equivalente ao `apt-get dist-upgrade`.

---

#### Instalar pacotes

```bash
sudo apt install nome_do_pacote
```

---

#### Remover pacotes

```bash
sudo apt remove nome_do_pacote
```

---

#### Remover pacotes + arquivos de configuração

```bash
sudo apt purge nome_do_pacote
```

---

#### Remover dependências não usadas

```bash
sudo apt autoremove
```

---

#### Buscar pacotes

```bash
apt search nome_do_pacote
```

---

#### Mostrar informações de um pacote

```bash
apt show nome_do_pacote
```

---

#### Listar pacotes instalados

```bash
apt list --installed
```

---

#### Listar pacotes atualizáveis

```bash
apt list --upgradable
```

---

## 🔍 Diferenças entre `apt` e `apt-get`

| Característica           | `apt`      | `apt-get`           |
| ------------------------ | ---------- | ------------------- |
| Objetivo                 | Uso humano | Scripts e automação |
| Interface                | Amigável   | Simples             |
| Barra de progresso       | ✅          | ❌                   |
| Mensagens resumidas      | ✅          | ❌                   |
| Estabilidade da saída    | ⚠️         | ✅                   |
| Recomendado para scripts | ❌          | ✅                   |

---

## 🧠 Regra prática que aprendi

* ✔ **Uso diário / estudos / terminal** → `apt`
* ✔ **Scripts / servidores / automação** → `apt-get`

> Mesmo que ambos façam a mesma coisa, **o contexto de uso muda completamente**.

---

## 📌 Conclusão

O `apt-get` continua sendo essencial por sua **confiabilidade e previsibilidade**.
O `apt` existe para tornar o dia a dia no terminal **mais simples e agradável**.

Entender essa diferença é fundamental para:

* Administração de sistemas
* Escrita de scripts
* Estudos em Linux, DevOps e Infraestrutura

Este documento representa meu aprendizado prático sobre gerenciamento de pacotes no Linux.
