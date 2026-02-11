## 📁 Criação e remoção de diretórios

Nesta etapa do meu aprendizado, estudei como **criar, organizar e remover diretórios** pelo terminal.  
Esses comandos são fundamentais para estruturar projetos, organizar ambientes e trabalhar em servidores Linux.

---

### `mkdir`
Cria diretórios.

- `mkdir pasta` → cria um diretório  
- `mkdir pasta1 pasta2` → cria múltiplos diretórios  
- `mkdir -p caminho/pasta` → cria diretórios aninhados, mesmo que os intermediários não existam  
- `mkdir -v pasta` → cria o diretório exibindo o que foi criado  

---

### `rmdir`
Remove diretórios **vazios**.

- `rmdir pasta` → remove o diretório se estiver vazio  
- `rmdir -p caminho/pasta` → remove diretórios vazios em cadeia  

---

### `rm`
Remove arquivos e diretórios.

- `rm arquivo` → remove um arquivo  
- `rm -i arquivo` → pede confirmação antes de remover  
- `rm -r pasta` → remove diretório e seu conteúdo  
- `rm -rf pasta` → remove diretório e conteúdo sem confirmação (**uso crítico**)  
- `rm -v arquivo` → exibe o que está sendo removido  

---

### Combinações comuns
- `rm -rv pasta` → remove diretório recursivamente mostrando o que foi apagado  
- `rm -ri pasta` → remove diretório pedindo confirmação item a item  

---

### Boas práticas aprendidas
- Sempre conferir o caminho com `pwd`  
- Usar `ls` antes de remover diretórios  
- Preferir `-i` ou `-v` durante estudos  
- Evitar `rm -rf` sem absoluta certeza  
  
