# 📁 Comando `mv` no Linux — Minha Jornada de Aprendizado

Este documento faz parte do meu **laboratório pessoal de estudos em Linux, Infraestrutura e DevOps**.  
Aqui eu registro meu aprendizado sobre o comando **`mv`**, utilizado para **mover e renomear arquivos e diretórios** no Linux.

---

## 🧠 O que é o comando `mv`

O comando **`mv`** vem de *move* (mover).  
Ele é usado para:

- Mover arquivos
- Mover diretórios
- Renomear arquivos
- Renomear diretórios

📌 Diferente do `cp`, o `mv` **remove o arquivo do local original**.

### Sintaxe básica:
```bash
mv [opções] origem destino
````

---

## 📁 Movendo arquivos (casos básicos)

### Mover um arquivo para outro diretório

```bash
mv arquivo.txt /home/usuario/Documentos/
```

➡ O arquivo **deixa de existir** no local original.

---

### Mover vários arquivos de uma vez

```bash
mv a.txt b.txt c.txt /backup/
```

---

## ✏️ Renomeando arquivos

Renomear um arquivo nada mais é do que **movê-lo dentro do mesmo diretório**.

```bash
mv arquivo.txt arquivo_novo.txt
```

✔ O conteúdo não muda
✔ Apenas o nome

---

## 📂 Movendo diretórios

O `mv` **move diretórios sem precisar de `-r`** (diferente do `cp`).

```bash
mv pasta1 /backup/
```

---

### Renomear diretórios

```bash
mv projeto projeto_antigo
```

---

## 🛠️ Opções mais importantes do `mv`

### 🔹 `-v` — Verbose

Mostra o que está sendo movido.

```bash
mv -v arquivo.txt /tmp/
```

Muito útil para aprendizado e scripts.

---

### 🔹 `-i` — Interativo

Pergunta antes de sobrescrever arquivos.

```bash
mv -i arquivo.txt /destino/
```

⚠️ Extremamente recomendado para evitar sobrescritas acidentais.

---

### 🔹 `-f` — Forçar

Força a movimentação sem perguntar.

```bash
mv -f arquivo.txt /destino/
```

⚠️ Pode sobrescrever arquivos sem aviso.

---

### 🔹 `-n` — No clobber

Não sobrescreve arquivos existentes.

```bash
mv -n arquivo.txt /destino/
```

---

## 🔐 Permissões e o comando `mv`

O comportamento do `mv` depende do cenário:

### 🔹 Dentro do mesmo sistema de arquivos

* Apenas altera o **nome/ponteiro**
* É uma operação rápida
* Permissões e dono permanecem

### 🔹 Entre sistemas de arquivos diferentes

* O `mv` faz:

  1. Uma cópia
  2. Remove o arquivo original

Nesse caso:

* Permissões podem mudar
* Pode exigir `sudo`

Exemplo:

```bash
mv arquivo /mnt/hd_externo/
```

---

## ⚠️ Atenção ao sobrescrever arquivos

O `mv` **sobrescreve arquivos por padrão**.

Exemplo perigoso:

```bash
mv arquivo.txt /destino/
```

Se já existir um `arquivo.txt` no destino, ele será perdido.

📌 Forma mais segura:

```bash
mv -i arquivo.txt /destino/
```

---

## 🧪 Exemplos práticos do dia a dia

### Organizar arquivos por tipo

```bash
mv *.log logs/
```

---

### Mover projetos antigos

```bash
mv projeto_antigo/ /backup/projetos/
```

---

### Renomear arquivos em lote (simples)

```bash
mv relatorio_v1.txt relatorio_final.txt
```

---

## ❌ Erros comuns de iniciantes

* Usar `mv` achando que está copiando
* Sobrescrever arquivos sem perceber
* Não usar `-i`
* Usar `sudo` sem necessidade

---

## 🧠 Diferença entre `cp` e `mv`

| Comando | Comportamento                        |
| ------- | ------------------------------------ |
| `cp`    | Copia e mantém o original            |
| `mv`    | Move ou renomeia (remove o original) |

📌 Se usar `mv`, **não existe cópia de segurança automática**.

---

## 🎯 Regra de ouro

Antes de mover arquivos importantes:

```bash
mv -iv origem destino
```

* `-i` evita sobrescrita
* `-v` mostra o que está acontecendo

---

## 📚 Conclusão

O comando `mv` é simples, rápido e extremamente poderoso.
Ele é usado diariamente para:

* organização de arquivos
* renomeações
* automação
* administração de sistemas

Entender bem o `mv` evita **perda de dados** e **erros graves** no Linux.
