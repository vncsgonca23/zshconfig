#!/bin/bash

# Função para remover diretórios e exibir mensagens de status
remove_dir() {
  if [ -d "$1" ]; then
    rm -rf "$1"
    echo "Removido: $1"
  else
    echo "Diretório não encontrado: $1"
  fi
}

# Função para remover arquivo e exibir mensagens de status
remove_file() {
  if [ -f "$1" ]; then
    rm -f "$1"
    echo "Removido: $1"
  else
    echo "Arquivo não encontrado: $1"
  fi
}

# Remover configuração do Neovim
echo "Removendo diretórios e arquivos de configuração do Neovim..."
remove_dir "~/.config/nvim"
remove_dir "~/.local/share/nvim"
remove_dir "~/.local/state/nvim"
remove_dir "~/.cache/nvim"

# Remover Packer (gerenciador de plugins)
echo "Removendo o gerenciador de plugins Packer..."
remove_dir "~/.local/share/nvim/site/pack/packer"

# Remover arquivos de fontes MesloLGS NF instalados
echo "Removendo fontes MesloLGS NF..."
remove_file "~/.local/share/fonts/MesloLGS NF Regular.ttf"
remove_file "~/.local/share/fonts/MesloLGS NF Bold.ttf"
remove_file "~/.local/share/fonts/MesloLGS NF Italic.ttf"
remove_file "~/.local/share/fonts/MesloLGS NF Bold Italic.ttf"

# Atualizar cache de fontes
echo "Atualizando cache de fontes..."
fc-cache -fv

# Remover ferramentas adicionais (fzf)
echo "Removendo ferramentas adicionais (fzf)..."
sudo pacman -Rns --noconfirm fzf

# Mensagem final
echo "Desinstalação e limpeza relacionadas ao Neovim concluídas!"
