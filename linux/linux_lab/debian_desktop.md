# Usuários, Grupos e Privilégios no Debian — Minha Jornada de Aprendizado

Este documento faz parte do meu **processo de estudo em Linux**, com foco em **administração de sistemas**, **segurança** e **boas práticas** usadas em ambientes profissionais.

Aqui eu registro meu entendimento sobre **criação de usuários, grupos e gerenciamento de privilégios no Debian**, destacando também as **diferenças em relação ao Ubuntu**, principalmente no que diz respeito ao usuário `root`.

---

## 🎯 Objetivo deste estudo

- Entender como funciona a criação de usuários e grupos no Debian
- Compreender o papel do usuário `root`
- Comparar o modelo de privilégios do Debian com o Ubuntu
- Registrar decisões e conceitos, não apenas comandos

---

## 👤 Usuários no Linux (conceito geral)

No Linux:
- Todo usuário possui um **UID**
- Todo usuário pertence a um **grupo primário**
- Pode pertencer a **grupos secundários**
- As permissões de acesso são baseadas em:
  - dono
  - grupo
  - outros

Esses conceitos são comuns a praticamente todas as distribuições Linux.

---

## 🔐 O usuário `root` no Debian

Durante a instalação do **Debian**, ocorre algo importante:

- É definida **uma senha para o usuário root**
- É criado pelo menos **um usuário comum** (ex: `diego`)

Isso significa que, no Debian:
- O usuário `root` **existe e está ativo**
- Ele pode ser acessado diretamente com senha
- O comando `su` funciona normalmente

### Exemplo:
```bash
su
# digita a senha do root
````

Qualquer usuário que **souber a senha do root** consegue obter acesso total ao sistema.

---

## ⚠️ Implicações de segurança

Esse comportamento é poderoso, mas perigoso se mal administrado:

* Compartilhar a senha do root = acesso total
* Não há controle fino por usuário
* Auditoria fica mais difícil

Por isso, em ambientes profissionais, o uso direto do `root` costuma ser evitado.

---

## 🔄 Diferença entre Debian e Ubuntu (root)

Apesar de ambos serem baseados no mesmo ecossistema, **Debian e Ubuntu tratam o root de forma diferente**.

### 📊 Comparação prática

| Aspecto         | Debian                      | Ubuntu                    |
| --------------- | --------------------------- | ------------------------- |
| Root ativo      | ✅ Sim                       | ❌ Não                     |
| Senha do root   | ✅ Definida na instalação    | ❌ Não definida            |
| `su`            | ✅ Funciona                  | ❌ Normalmente bloqueado   |
| `sudo`          | Opcional                    | Padrão                    |
| Usuário inicial | Não é admin automaticamente | Já pertence ao grupo sudo |

No **Ubuntu**, o modelo padrão é:

* Root desativado
* Usuário comum usa `sudo`

No **Debian**, o modelo padrão é:

* Root separado
* Controle baseado em senha do root

---

## 🛠️ Uso de `sudo` no Debian

Mesmo no Debian, é possível (e recomendado) usar `sudo`.

### Instalar o sudo:

```bash
apt install sudo
```

### Adicionar um usuário ao grupo sudo:

```bash
usermod -aG sudo diego
```

Após isso:

* `diego` pode usar `sudo`
* outros usuários não

Isso permite:

* Melhor controle
* Logs de comandos administrativos
* Menor exposição da senha do root

---

## 👥 Usuários comuns e privilégios

Um usuário comum (ex: `lucas`):

* Não é root
* Não tem acesso administrativo
* Só consegue virar root se souber a senha do root (via `su`)

Esse comportamento reforça a importância de **não compartilhar a senha do root**.

---

## 🧠 Conclusão do aprendizado

* Debian mantém o root **ativo e separado**
* Ubuntu prioriza o uso de `sudo`
* Os comandos de criação de usuários e grupos são praticamente os mesmos
* A grande diferença está no **modelo de privilégio**
* Em ambientes profissionais, o ideal é:

  * usar `sudo`
  * restringir o uso direto do root
  * documentar decisões, não só comandos

Este estudo me ajudou a entender melhor **segurança, controle de acesso e boas práticas** no Linux.

---

📌 *Documento criado como parte do meu processo contínuo de aprendizado em Linux e Infraestrutura.*