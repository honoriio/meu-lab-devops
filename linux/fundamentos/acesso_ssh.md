## 🔐 Acesso remoto com SSH (Secure Shell)

Nesta etapa do meu aprendizado, estudei como **instalar, configurar e utilizar o SSH** para acessar máquinas Linux remotamente.  
O SSH é fundamental para administração de servidores, automação, DevOps e ambientes em nuvem.

---

### Instalação do SSH

- `sudo apt update` → atualiza a lista de pacotes  
- `sudo apt install openssh-server` → instala o servidor SSH  
- `sudo systemctl status ssh` → verifica se o serviço está ativo  
- `sudo systemctl start ssh` → inicia o serviço SSH  
- `sudo systemctl enable ssh` → inicia o SSH automaticamente no boot  

---

### Conexão via SSH

- `ssh usuario@ip` → conecta a um servidor remoto  
- `ssh usuario@hostname` → conecta usando nome da máquina  
- `ssh -p 2222 usuario@ip` → conecta usando porta personalizada  

---

### Encerrando sessão SSH

- `exit` → encerra a conexão  
- `Ctrl + D` → encerra a sessão atual  

---

### Descobrindo o IP da máquina

- `ip a` → mostra informações de rede  
- `hostname -I` → mostra o IP da máquina  
- `ip route` → mostra o gateway e rota padrão  

---

### Acesso remoto em rede local (modo ponte)

Para acessar a máquina Linux a partir de outro computador na mesma rede:

- Configurar a VM em **modo Bridge (ponte)**  
- A máquina recebe um **IP da mesma rede do host**  
- Permite acesso direto via SSH entre dispositivos  

Exemplo de conexão:
- `ssh usuario@ip_da_maquina_linux`

---

### Acesso remoto fora da rede (VPN)

Para acessar a máquina remotamente fora da rede local:

- Utilizar uma **VPN** para entrar na mesma rede  
- Após conectar na VPN, usar SSH normalmente  
- Mantém a conexão **segura e criptografada**  

---

### Transferência de arquivos via SSH

- `scp arquivo.txt usuario@ip:/caminho` → envia arquivo para o servidor  
- `scp usuario@ip:/caminho/arquivo.txt .` → baixa arquivo do servidor  
- `scp -r pasta usuario@ip:/caminho` → envia diretórios  

---

### Autenticação por chave SSH

- `ssh-keygen` → gera um par de chaves SSH  
- `ssh-copy-id usuario@ip` → copia a chave pública para o servidor  
- `ssh usuario@ip` → conecta sem pedir senha  

---

### Boas práticas aprendidas
- Manter o serviço SSH ativo apenas quando necessário  
- Preferir autenticação por chave ao invés de senha  
- Conferir IP e rede antes de tentar conexão  
- Usar VPN para acesso remoto fora da rede local  
