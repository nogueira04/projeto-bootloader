# Bootloader - IF677: Infraestrutura de Software

Este projeto é um bootloader desenvolvido como parte da disciplina IF677 - Infraestrutura de Software. O objetivo é fornecer uma introdução prática ao funcionamento de sistemas de baixo nível, abordando conceitos como carregamento de kernel, manipulação de disco e interface gráfica básica em Assembly. O objetivo do jogo é acertar um conjunto de logos.

## 📁 Estrutura do Projeto

```
projeto-IS/
├── boot1.asm                # Primeiro estágio do bootloader
├── boot2.asm                # Segundo estágio do bootloader
├── kernel.asm               # Código do kernel principal
├── data.asm                 # Dados auxiliares utilizados pelo sistema
├── imageandvideo.asm        # Rotinas para exibição de imagens e vídeos
├── menu_winner_loser_functions.asm  # Funções para menus de vitória e derrota
├── disk.img                 # Imagem do disco contendo o sistema
├── Makefile                 # Script de automação para compilação
├── logos/                   # Diretório com imagens e logos utilizados
├── *.bin                    # Arquivos binários gerados após compilação
└── README.md                # Documentação do projeto
```

## 🚀 Como Executar

Para compilar e executar o bootloader, siga os passos abaixo:

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/marigmsc/projeto-IS.git
   cd projeto-IS
   ```

2. **Compile o projeto:**

   Certifique-se de ter o NASM e o QEMU instalados em seu sistema. Em seguida, execute:

   ```bash
   make
   ```

   Este comando irá compilar os arquivos `.asm` e gerar a imagem `disk.img`.

3. **Execute a imagem:**

   Utilize o QEMU para emular a imagem do disco:

   ```bash
   qemu-system-i386 -fda disk.img
   ```

   Isso iniciará o bootloader em um ambiente emulado.

## 🛠️ Requisitos

- [NASM](https://www.nasm.us/) - Montador para linguagem Assembly
- [QEMU](https://www.qemu.org/) - Emulador de hardware para testar o bootloader
