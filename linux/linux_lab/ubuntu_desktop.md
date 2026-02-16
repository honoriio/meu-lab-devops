# Ambiente de Desenvolvimento Python no Ubuntu  
## Minha Jornada de Aprendizado em Infraestrutura e Desenvolvimento

Este documento faz parte do meu **laboratório pessoal de estudos em Linux, Infraestrutura e Desenvolvimento Python**.  
Aqui eu documento o processo de **preparação de uma máquina Ubuntu para um usuário desenvolvedor Python**, seguindo práticas comuns no mercado.

O objetivo é entender **como preparar um ambiente funcional, organizado e profissional**, e não apenas instalar ferramentas de forma aleatória.

---

## 🎯 Objetivo do Ambiente

- Preparar um usuário dedicado para desenvolvimento Python
- Garantir isolamento de dependências
- Manter o sistema organizado e seguro
- Utilizar ferramentas amplamente usadas no mercado

---

## 🧱 Ferramentas Básicas do Sistema

Antes de qualquer coisa, é importante instalar ferramentas essenciais que dão suporte ao desenvolvimento.

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  unzip \
  zip \
  ca-certificates \
  software-properties-common
````

### Por que essas ferramentas são importantes?

* `build-essential`: necessário para compilar dependências nativas do Python
* `git`: controle de versão e colaboração
* `curl` e `wget`: consumo de APIs e automações
* `zip/unzip`: manipulação de arquivos

---

## 🐍 Gerenciamento de Versões do Python

Aprendi que **não é uma boa prática depender apenas do Python do sistema**, pois projetos diferentes exigem versões diferentes.

Para resolver isso, utilizei o **pyenv**, que permite instalar e alternar entre múltiplas versões do Python.

### Instalação do pyenv

```bash
curl https://pyenv.run | bash
```

Configuração no arquivo `.bashrc`:

```bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```

### Instalação de versões do Python

```bash
pyenv install 3.10.13
pyenv install 3.11.8
pyenv global 3.11.8
```

---

## 📦 Gerenciamento de Dependências e Ambientes Virtuais

Para manter projetos isolados e organizados, utilizei ferramentas específicas para ambientes virtuais e dependências.

```bash
pip install --user virtualenv pipx
```

### Ferramentas instaladas com pipx

```bash
pipx install poetry
pipx install black
pipx install flake8
pipx install mypy
```

* **Poetry**: gerenciamento de dependências e ambientes virtuais
* **Black**: formatação automática de código
* **Flake8**: análise de estilo
* **Mypy**: checagem de tipos

---

## 🧪 Testes e Debug

Ferramentas que ajudam a testar e depurar aplicações Python.

```bash
pipx install pytest
pipx install ipython
```

* `pytest`: testes automatizados
* `ipython`: console interativo avançado

---

## 🧠 Editor de Código (IDE)

Optei por utilizar o **VS Code**, por ser amplamente adotado e possuir ótima integração com Python.

```bash
sudo snap install code --classic
```

### Extensões utilizadas

* Python
* Pylance
* Black Formatter
* GitLens
* Docker (opcional)

---

## 🗄️ Banco de Dados para Desenvolvimento Local

Para testes e desenvolvimento local, instalei bancos de dados comuns no mercado.

```bash
sudo apt install -y postgresql postgresql-contrib sqlite3
```

---

## 🐳 Containers com Docker

Aprendi que o uso de containers é muito valorizado e facilita a padronização do ambiente.

```bash
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker dev1
```

---

## 🔐 Segurança e Boas Práticas

Para manter qualidade e segurança no código, utilizei ferramentas de análise estática.

```bash
pipx install bandit
pipx install pre-commit
```

* `bandit`: análise de segurança em código Python
* `pre-commit`: automação de verificações antes dos commits

---

## 📁 Organização de Diretórios

Para manter tudo organizado, adotei a seguinte estrutura:

```bash
/home/dev1/
├── projetos/
│   ├── api/
│   ├── scripts/
│   └── estudos/
├── .pyenv/
├── .cache/
└── .config/
```

---

## ✅ Conclusão

Com esse setup, o ambiente fica:

* Organizado
* Seguro
* Flexível para múltiplos projetos
* Próximo do padrão utilizado em empresas

Este laboratório faz parte do meu processo contínuo de aprendizado em **Linux, Infraestrutura e Desenvolvimento de Software**.

---
