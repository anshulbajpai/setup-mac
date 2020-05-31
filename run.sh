#!/bin/sh

touch ~/.bash_untracked
echo $'\n#!/bin/bash' > ~/.bash_untracked

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

#Install essential packages
brew install \
  coreutils automake autoconf openssl \
  libyaml readline libxslt libtool unixodbc \
  unzip curl git vim awscli gpg2 golang cfn-lint \
  htop jq colordiff asdf fzf gotop httpie \
  zsh zsh-completions

#Install applications
brew cask install \
	evernote dropbox intellij-idea-ce slack \
	brave-browser iterm2 spectacle postman \
	docker caffeine robo-3t virtualbox virtualbox-extension-pack \
	vlc visual-studio-code

#Install nerd-fonts
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

#Create ssh keys
ssh-keygen -t rsa -b 4096 -C "bajpai.anshul@gmail.com" -f ~/.ssh/github -N ""
ssh-keygen -t rsa -b 4096 -C "bajpai.anshul@gmail.com" -f ~/.ssh/bitbucket -N ""

#Configure zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

#Install powerline fonts (The steps below will do automatically)
#Check here for more details - https://www.freecodecamp.org/news/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38/

git clone https://github.com/powerline/fonts.git powerline-fonts
cd powerline-fonts
./install.sh
cd ../
rm -rf powerline-fonts

#Configure nerd fonts in iterm2 preference -> profile -> text
#Install  iTerm2 “color schemes” - Check here for more details - https://www.freecodecamp.org/news/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38

#Install vimrc
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/zeis/vim-kolor/master/colors/kolor.vim --output ~/.vim/colors/kolor.vim

#Install .dotfiles
rm -rf ~/.dotfiles
git clone https://github.com/anshulbajpai/.dotfiles.git ~/.dotfiles
ln -sv ~/.dotfiles/bash/.bash_aliases ~/.bash_aliases
ln -sv ~/.dotfiles/bash/.bash_functions ~/.bash_functions
ln -sv ~/.dotfiles/bash/.bash_env ~/.bash_env
ln -sv ~/.dotfiles/bash/.bash_profile ~/.bash_profile
ln -sv ~/.dotfiles/bash/.scripts ~/.scripts
ln -sv ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sv ~/.dotfiles/ssh/config ~/.ssh/config
ln -sv ~/.dotfiles/vim/.vimrc ~/.vimrc
ln -sfv ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sv ~/.dotfiles/zsh/custom/history.zsh $ZSH_CUSTOM/history.zsh
ln -sv ~/.dotfiles/zsh/custom/zsh-autosuggestions.zsh $ZSH_CUSTOM/zsh-autosuggestions.zsh

echo $'\n. $(brew --prefix asdf)/asdf.sh' >> ~/.bash_untracked
echo $'\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' >> ~/.bash_untracked
echo $'\nexport PATH=$HOME/go/bin:$PATH' >> ~/.bash_untracked
echo $'\n. $(brew --prefix)/opt/fzf/install' >> ~/.bash_untracked
