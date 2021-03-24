#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias lm='ls -al | more'
alias vi='vim'
alias h='history'
# Set proxy to the system console
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1089" 
alias unsetproxy="unset ALL_PROXY"
#export ALL_PROXY=socks5://127.0.0.1:1089
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
