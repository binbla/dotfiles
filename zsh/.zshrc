export ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias zshconfig=". ~/.zshrc"
alias ohmyzsh=". ~/.oh-my-zsh"

# 自动补全
autoload -U compinit promptinit
compinit
promptinit
setopt autocd extendedglob
unsetopt beep
bindkey -v
# 启动使用方向键控制的自动补全
zstyle ':completion:*' menu select

# 按两次 tab 键启动菜单
setopt completealiases

# 配置提示符
# 使用主题
# prompt bart
# 使用自定义配置
if [ `whoami` = "root" ];then usign='#';else usign='$';fi
PROMPT="%{$fg[green]%}[%{$reset_color%}%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%{$fg[green]%}] %{$reset_color%}${usign} "
RPROMPT="%{$fg[green]%}%T%{$reset_color%} [%{$fg[yellow]%}%?%{$reset_color%}]"
unset usign
# 说明
# %T	系统时间（时：分）
# %*	系统时间（时：分：秒）
# %D	系统日期（年-月-日）
# %n	你的用户名
# %B - %b	开始到结束使用粗体打印
# %U - %u	开始到结束使用下划线打印
# %d	你目前的工作目录
# %~	你目前的工作目录相对于～的相对路径（可能在某些zsh版本可能造成乱码）
# %M	计算机的主机名
# %m	计算机的主机名（在第一个句号之前截断）
# %l  当前tty


# 自动更新path中可执行程序
zstyle ':completion:*' rehash true

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias lm='ls -al | more'
alias vi='vim'
alias h='history'
alias lsp='sudo pacman -Syu'
alias pacwoman='yay -Syu'
alias syu='yay -Syu'
# Set proxy to the system console
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1089" 
alias unsetproxy="unset ALL_PROXY"

# 帮助命令
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
#unalias run-help
alias help=run-help

#仿fish高亮
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

