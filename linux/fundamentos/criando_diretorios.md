## 📁 Criação e remoção de diretórios

Nesta etapa do meu aprendizado, estudei como **criar, organizar e remover diretórios** pelo terminal.  
Esses comandos são fundamentais para estruturar projetos, organizar ambientes e trabalhar em servidores Linux.

---

### `mkdir`
Cria um novo diretório.

- `mkdir pasta` → cria um diretório chamado `pasta`  
- `mkdir pasta1 pasta2` → cria múltiplos diretórios de uma vez  
- `mkdir -p caminho/completo/pasta` → cria diretórios aninhados, mesmo que os diretórios intermediários não existam  

---

### `rmdir`
Remove um diretório **vazio**.

- `rmdir pasta` → remove o diretório se ele estiver vazio  

---

### `rm`
Remove arquivos e diretórios.

- `rm arquivo` → remove um arquivo  
- `rm -r pasta` → remove um diretório e todo o seu conteúdo  
- `rm -rf pasta` → remove diretório e conteúdo **sem pedir confirmação** (uso cuidadoso)  

---

### Boas práticas aprendidas
- Sempre usar `pwd` antes de remover diretórios  
- Preferir `ls` para conferir o conteúdo antes de usar `rm -r`  
- Evitar `rm -rf` sem absoluta certeza do caminho  
