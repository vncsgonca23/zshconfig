#!/bin/bash

# Atualiza o sistema e instala dependências
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm neovim git curl unzip

# Cria diretórios necessários para o Neovim
mkdir -p ~/.config/nvim

# Instala o gerenciador de plugins 'Packer' para o Neovim
echo "Instalando o Packer (plugin manager)..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Cria um arquivo init.lua básico com as configurações do ThePrimeagen
cat << EOF > ~/.config/nvim/init.lua
-- Inicia o Packer
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim'  -- Packer pode gerenciar a si mesmo

  -- LSP e Autocompletion
  use {
    'neovim/nvim-lspconfig',    -- Configurações LSP
    'hrsh7th/nvim-cmp',         -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
    'L3MON4D3/LuaSnip',         -- Snippets plugin
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Temas e cores
  use 'morhetz/gruvbox'        -- Tema gruvbox

  -- Treesitter para melhor análise de código
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- Git
  use 'tpope/vim-fugitive'

  -- Comentário
  use 'tpope/vim-commentary'

  -- Movimentação entre buffers
  use 'ThePrimeagen/harpoon'

  -- Integração com GitHub
  use 'ThePrimeagen/git-worktree.nvim'
end)

-- Ativa o tema Gruvbox
vim.cmd 'colorscheme gruvbox'

-- Atalhos rápidos de movimentação
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })

-- LSP config
local lspconfig = require'lspconfig'
lspconfig.tsserver.setup{}
lspconfig.pyright.setup{}
lspconfig.gopls.setup{}

-- Configurações do Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "javascript", "python", "go" }, -- Linguagens suportadas
  highlight = {
    enable = true,
  },
}

-- Lualine config
require('lualine').setup {
  options = { theme = 'gruvbox' },
}
EOF

# Mensagem final
echo -e "\nInstalação e configuração do Neovim concluídas!"
echo "Para começar a usar, abra o Neovim e execute :PackerSync para instalar os plugins."
