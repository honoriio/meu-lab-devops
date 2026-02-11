## 📄 Criação de arquivos e manipulação de arquivos de texto

Nesta etapa do meu aprendizado, estudei como **criar arquivos**, **editar conteúdo**, **visualizar textos** e **manipular informações** diretamente pelo terminal.  
Esses comandos são essenciais para trabalhar com arquivos de configuração, logs e scripts em ambientes Linux.

---

### `touch`
Cria um arquivo vazio ou atualiza a data de modificação.

- `touch arquivo.txt` → cria um arquivo vazio  
- `touch arquivo1.txt arquivo2.txt` → cria múltiplos arquivos  
- `touch -t 202602101200 arquivo.txt` → define data e hora específicas  

---

### Redirecionamento (`>`, `>>`)
Cria arquivos e escreve conteúdo via terminal.

- `echo "texto" > arquivo.txt` → cria ou sobrescreve o arquivo  
- `echo "texto" >> arquivo.txt` → adiciona conteúdo ao final do arquivo  
- `> arquivo.txt` → cria um arquivo vazio  

---

### `cat`
Cria, exibe e concatena arquivos de texto.

- `cat arquivo.txt` → exibe o conteúdo do arquivo  
- `cat > arquivo.txt` → cria um arquivo e permite digitar conteúdo  
- `cat >> arquivo.txt` → adiciona conteúdo ao arquivo existente  
- `cat arq1.txt arq2.txt > novo.txt` → une arquivos em um novo  

---

### Editores de texto no terminal

#### `nano`
Editor simples e intuitivo.

- `nano arquivo.txt` → cria ou edita um arquivo  
- Atalhos comuns: `Ctrl + O` (salvar), `Ctrl + X` (sair)  

#### `vi / vim`
Editor avançado e poderoso.

- `vi arquivo.txt` ou `vim arquivo.txt` → cria ou edita um arquivo  
- Muito usado em servidores e ambientes de produção  

---

### Visualização de arquivos grandes

- `less arquivo.txt` → visualiza o arquivo página por página  
- `more arquivo.txt` → visualização simples, menos recursos  

---

### Leitura parcial de arquivos

- `head arquivo.txt` → mostra as primeiras 10 linhas  
- `head -n 5 arquivo.txt` → mostra as primeiras 5 linhas  
- `tail arquivo.txt` → mostra as últimas 10 linhas  
- `tail -n 5 arquivo.txt` → mostra as últimas 5 linhas  
- `tail -f arquivo.log` → acompanha atualizações em tempo real  

---

### Análise de conteúdo

- `wc arquivo.txt` → conta linhas, palavras e caracteres  
- `wc -l arquivo.txt` → conta apenas linhas  
- `sort arquivo.txt` → ordena linhas do arquivo  
- `uniq arquivo.txt` → remove linhas duplicadas consecutivas  
- `grep "texto" arquivo.txt` → busca texto dentro do arquivo  

---

### Boas práticas aprendidas
- Usar `touch` para criação rápida de arquivos  
- Preferir `nano` no início e `vim` em ambientes profissionais  
- Utilizar `less` para arquivos grandes  
- Nunca editar arquivos críticos sem antes visualizá-los  
