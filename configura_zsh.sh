#!/bin/bash

# Atualiza o sistema
sudo pacman -Syu --noconfirm

# Instala zsh e dependências
sudo pacman -S --noconfirm zsh git curl wget

# Define o zsh como shell padrão
chsh -s $(which zsh)

# Instala Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clona o tema Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
"${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Define o tema no .zshrc
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Instala as fontes MesloLGS NF
cd ~/Downloads
wget -O "MesloLGS NF Regular.ttf" \
"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -O "MesloLGS NF Bold.ttf" \
"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -O "MesloLGS NF Italic.ttf" \
"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -O "MesloLGS NF Bold Italic.ttf" \
"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

mkdir -p ~/.local/share/fonts
cp *.ttf ~/.local/share/fonts/
fc-cache -fv

# Retorna ao diretório inicial
cd ~

# Instala o plugin zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
"${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# Instala o plugin zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
"${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Adiciona os plugins ao .zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Garante que zsh-syntax-highlighting seja carregado por último
echo "source ${(q-)PWD}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# Instala ferramentas adicionais
sudo pacman -S --noconfirm fzf bat exa

# Adiciona aliases ao .zshrc
echo 'alias cat="batcat"' >> ~/.zshrc
echo 'alias ls="exa --icons"' >> ~/.zshrc

# Adiciona aliases Git ao .zshrc
echo 'alias gs="git status"' >> ~/.zshrc
echo 'alias ga="git add"' >> ~/.zshrc
echo 'alias gc="git commit"' >> ~/.zshrc
echo 'alias gp="git push"' >> ~/.zshrc

# Recarrega o .zshrc
source ~/.zshrc

# Mensagem final
echo -e "\nInstalação e configuração concluídas!"
echo "Por favor, configure seu emulador de terminal para usar a fonte 'MesloLGS NF'."
echo "Abra um novo terminal para iniciar o assistente de configuração do Powerlevel10k."
