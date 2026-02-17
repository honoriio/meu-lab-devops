# ⚙️ Processos no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **laboratório pessoal de estudos em Linux, Infraestrutura e DevOps**.  
Aqui eu registro meu aprendizado sobre **processos no Linux**, incluindo como **listar, analisar, monitorar e finalizar processos**.

---

## 🧠 O que é um processo no Linux?

Um **processo** é um programa em execução na memória.

📌 Exemplos:
- Um terminal aberto
- Um servidor web rodando
- Um script em execução
- Um serviço em segundo plano

Cada processo possui:
- **PID** (Process ID)
- Usuário dono
- Consumo de CPU e memória
- Estado
- Prioridade

---

## 🆔 PID — Process ID

O **PID** é um número único que identifica um processo.

Exemplo:
```bash
PID 1234 → firefox
````

📌 Todo processo no Linux tem um PID.

---

## 📋 Listando processos

### 🔹 `ps` — Process Status

Mostra processos em execução.

```bash
ps
```

Mostra apenas os processos do terminal atual.

---

### 🔹 Processos de um usuário

```bash
ps -u usuario
```

---

### 🔹 Todos os processos do sistema (mais usado)

```bash
ps aux
```

Significado:

* `a` → todos os usuários
* `u` → formato amigável
* `x` → processos sem terminal

---

### 🔹 Buscar um processo específico

```bash
ps aux | grep nginx
```

⚠️ O `grep` também aparece na lista.

---

## 📊 Monitorando processos em tempo real

### 🔹 `top`

```bash
top
```

Mostra:

* CPU
* Memória
* Processos em tempo real

Atalhos úteis dentro do `top`:

* `q` → sair
* `k` → matar processo
* `P` → ordenar por CPU
* `M` → ordenar por memória

---

### 🔹 `htop` (mais amigável)

```bash
htop
```

📌 Geralmente precisa ser instalado:

```bash
sudo apt install htop
```

Vantagens:

* Interface colorida
* Navegação com teclado/mouse
* Muito mais legível

---

## 🔍 Encontrando processos

### 🔹 `pgrep`

Busca processos pelo nome.

```bash
pgrep firefox
```

Retorna apenas o PID.

---

### 🔹 `pidof`

Mostra o PID de um programa.

```bash
pidof sshd
```

---

## ❌ Finalizando (matando) processos

### 🔹 `kill`

Envia sinais para um processo.

```bash
kill PID
```

Por padrão, envia o sinal **SIGTERM (15)**.

---

### 🔹 Sinais mais importantes

| Sinal   | Número | Função                        |
| ------- | ------ | ----------------------------- |
| SIGTERM | 15     | Finaliza de forma educada     |
| SIGKILL | 9      | Mata imediatamente            |
| SIGHUP  | 1      | Reinicia ou recarrega configs |

---

### 🔹 Matar processo à força

```bash
kill -9 PID
```

⚠️ Use apenas se o processo não responder.

---

### 🔹 Matar pelo nome do processo

```bash
pkill firefox
```

Ou:

```bash
killall firefox
```

📌 `killall` mata **todos os processos com aquele nome**.

---

## ⚠️ Cuidado ao matar processos

* Nunca mate processos críticos sem saber o que está fazendo
* Evite usar `kill -9` como primeira opção
* Sempre tente:

```bash
kill PID
```

antes do:

```bash
kill -9 PID
```

---

## 🧠 Estados dos processos

Principais estados:

| Estado | Significado              |
| ------ | ------------------------ |
| R      | Running (executando)     |
| S      | Sleeping (esperando)     |
| D      | Espera não interrompível |
| Z      | Zombie                   |
| T      | Parado                   |

---

### 🔹 Processos zumbi

* Já finalizaram
* Ainda estão na tabela de processos
* Normalmente causados por processo pai mal comportado

---

## ⚖️ Prioridade de processos

### 🔹 `nice`

Define prioridade ao iniciar um processo.

```bash
nice -n 10 comando
```

Valores:

* -20 → maior prioridade
* 19 → menor prioridade

---

### 🔹 `renice`

Altera prioridade de um processo em execução.

```bash
renice -n 5 -p PID
```

---

## 🧪 Exemplos práticos do dia a dia

### Ver processos consumindo muita CPU

```bash
ps aux --sort=-%cpu | head
```

---

### Ver processos consumindo muita memória

```bash
ps aux --sort=-%mem | head
```

---

### Matar um processo travado

```bash
ps aux | grep nome_processo
kill PID
```

Se não funcionar:

```bash
kill -9 PID
```

---

## ❌ Erros comuns de iniciantes

* Matar processo errado
* Usar `kill -9` sem necessidade
* Não verificar PID antes
* Matar processos do sistema

---

## 🎯 Regra de ouro

Antes de matar qualquer processo:

1. Identifique o processo corretamente
2. Use `kill` sem `-9`
3. Só force se realmente travar

---

## 📚 Conclusão

Entender processos no Linux é essencial para:

* administração de servidores
* troubleshooting
* performance
* segurança

Esse conhecimento separa **usuário comum** de **administrador de sistemas**.
