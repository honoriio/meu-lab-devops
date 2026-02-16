# Aula Completa: Discos, Partições e Sistemas de Arquivos no Linux
## Minha Jornada de Aprendizado Avançada

Nesta aula, vou documentar **tudo que aprendi sobre discos, partições e sistemas de arquivos no Linux (Debian/Ubuntu)**.  
Vou cobrir desde conceitos básicos até **configurações avançadas como swap, RAID e LVM**, incluindo comandos, boas práticas e exemplos práticos.

---

## 💾 1. Discos

### Conceito
Um **disco** é um dispositivo físico de armazenamento de dados. No Linux, eles aparecem como arquivos especiais em `/dev`:

| Dispositivo | Exemplo | Observações |
|------------|---------|------------|
| Disco SATA/SSD | `/dev/sda` | Primeiro disco |
| Segundo disco | `/dev/sdb` | Segundo disco conectado |
| NVMe | `/dev/nvme0n1` | Discos mais rápidos modernos |

### Comandos essenciais
- Listar discos e partições:
```bash
lsblk
sudo fdisk -l
````

* Visualizar uso de disco:

```bash
df -h
```

* Detalhes do hardware:

```bash
sudo lshw -class disk
```

---

## 🧩 2. Partições

### O que são

* Uma **partição** é uma divisão lógica do disco físico.
* Cada partição pode ter:

  * Um **sistema de arquivos**
  * Um **ponto de montagem**

### Tipos de partições

1. **Primária**: até 4 por disco, geralmente para sistema e boot.
2. **Estendida**: permite criar partições lógicas dentro dela.
3. **Lógica**: partições criadas dentro da estendida, usadas para dados adicionais.

### Visualização

```bash
lsblk
sudo fdisk -l
sudo parted /dev/sda print
```

### Criando e gerenciando partições

* **MBR (Master Boot Record)** – padrão antigo

```bash
sudo fdisk /dev/sda
```

* **GPT (GUID Partition Table)** – recomendado para discos >2TB

```bash
sudo parted /dev/sda
(parted) mklabel gpt
```

---

## 🗂️ 3. Sistemas de Arquivos (Filesystems)

### Conceito

O **sistema de arquivos** define como os dados são organizados, lidos e escritos na partição.

### Sistemas de arquivos comuns

| Sistema | Uso                             | Observações                                      |
| ------- | ------------------------------- | ------------------------------------------------ |
| ext4    | Linux desktop e servidores      | Estável e rápido                                 |
| xfs     | Servidores grandes              | Excelente para arquivos grandes                  |
| btrfs   | Avançado                        | Snapshots, compressão e RAID nativo              |
| vfat    | Pen drives / compatível Windows | FAT32, sem permissões Linux                      |
| ntfs    | Dual boot Windows               | Permite leitura/escrita, mas mais lento no Linux |

### Comandos básicos

* Formatar uma partição:

```bash
sudo mkfs.ext4 /dev/sda1
sudo mkfs.xfs /dev/sdb1
sudo mkfs.vfat /dev/sdc1
```

* Ver sistema de arquivos:

```bash
lsblk -f
sudo blkid
```

* Montar partição:

```bash
sudo mount /dev/sda1 /mnt
```

* Desmontar:

```bash
sudo umount /mnt
```

* Montagem automática no boot (`/etc/fstab`):

```text
/dev/sda1   /dados   ext4   defaults   0   2
```

---

## ⚡ 4. Swap (Memória de troca)

* **Swap** é espaço em disco usado como **memória virtual**.
* Permite que o sistema continue funcionando quando a RAM está cheia.
* Pode ser:

  * **Partição swap**
  * **Arquivo swap**

### Criar arquivo swap

```bash
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

* Ver swap ativo:

```bash
swapon --show
```

---

## 🛠️ 5. RAID (Redundant Array of Independent Disks)

* RAID combina múltiplos discos para **desempenho ou redundância**.
* Tipos comuns:

  * RAID 0: performance (striping), sem redundância
  * RAID 1: espelhamento (mirroring), alta segurança
  * RAID 5/6: paridade, mistura de segurança e espaço
  * RAID 10: espelhamento + striping, performance e segurança

### Criar RAID (exemplo RAID 1)

```bash
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
sudo mkfs.ext4 /dev/md0
sudo mount /dev/md0 /mnt/raid
```

---

## 🔧 6. LVM (Logical Volume Manager)

* LVM permite **gerenciar volumes de forma flexível**, sem precisar redimensionar partições físicas.
* Conceitos:

  * PV → Physical Volume (disco ou partição)
  * VG → Volume Group (conjunto de PVs)
  * LV → Logical Volume (equivalente a partições, mas flexíveis)

### Comandos básicos

```bash
# Criar PV
sudo pvcreate /dev/sdb

# Criar VG
sudo vgcreate vg_dados /dev/sdb

# Criar LV
sudo lvcreate -L 20G -n lv_dados vg_dados

# Formatar e montar LV
sudo mkfs.ext4 /dev/vg_dados/lv_dados
sudo mount /dev/vg_dados/lv_dados /mnt/dados
```

---

## 📌 7. Boas práticas avançadas

1. Sempre **backup antes de particionar ou formatar**.
2. Use **GPT** para discos modernos (>2TB).
3. Para servidores:

   * Separar `/`, `/home`, `/var` e swap.
4. Considere **RAID ou LVM** para flexibilidade e segurança.
5. Prefira **ext4** para compatibilidade, ou XFS/Btrfs para casos específicos.
6. Mantenha **swap suficiente** ou ajuste `vm.swappiness` conforme uso de RAM.
7. Atualize o **`/etc/fstab`** com UUIDs em vez de nomes de dispositivo para evitar problemas ao adicionar novos discos.

---

## 🧠 8. Comandos de referência rápida

| Ação                    | Comando                                         |
| ----------------------- | ----------------------------------------------- |
| Listar discos           | `lsblk`, `sudo fdisk -l`                        |
| Ver sistema de arquivos | `lsblk -f`, `sudo blkid`                        |
| Criar partição          | `sudo fdisk /dev/sda`, `sudo parted /dev/sda`   |
| Formatar                | `sudo mkfs.ext4 /dev/sda1`                      |
| Montar/Desmontar        | `sudo mount /dev/sda1 /mnt`, `sudo umount /mnt` |
| Criar swap              | `fallocate`, `mkswap`, `swapon`                 |
| RAID                    | `mdadm --create`                                |
| LVM                     | `pvcreate`, `vgcreate`, `lvcreate`              |

---

## 🧠 9. Conclusão

Com essa aula avançada, consigo:

* Entender **como os discos funcionam fisicamente e logicamente**
* Criar e gerenciar **partições e sistemas de arquivos**
* Usar **swap, RAID e LVM** para servidores e desktops avançados
* Montar volumes de forma flexível e segura
* Garantir **boa organização e desempenho** do sistema

> Este material representa meu estudo contínuo em Linux, administração de sistemas, infraestrutura e preparação para ambientes profissionais e DevOps.

```

---