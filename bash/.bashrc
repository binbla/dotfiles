#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# ~/.bashrc
#

export HISTCONTROL=ignoreboth:erasedups
bind "set completion-ignore-case on"
# Make nano the default editor
export EDITOR='vim'
export VISUAL='vim'

PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

[[ -f ~/.bashrc-alias ]] && . ~/.bashrc-alias
PS1='[\u@\h \W]\$ '
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# reporting tools - install when not installed
# install neofetch
neofetch
# install screenfetch
#screenfetch
# install ufetch-git
#ufetch
# install ufetch-arco-git
#ufetch-arco
# install arcolinux-paleofetch-git
#paleofetch
# install alsi
#alsi
# install arcolinux-bin-git - standard on ArcoLinux isos (or sfetch - smaller)
#hfetch
# install lolcat
# neofetch | lolcat



