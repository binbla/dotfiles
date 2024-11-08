#git stow zsh og-my-zsh-git powerline ranger exa zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search

# ohmyzsh
export ZSH="/usr/share/oh-my-zsh"
# dot文件目录
export DOTFILES_DIR="${HOME}/dotfiles"

# 补全缓存 提前定义好缓存目录
export ZDOTDIR="${DOTFILES}/zsh"
export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${ZSH_VERSION}"

source $ZSH/oh-my-zsh.sh
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

alias zshconfig=". ~/.zshrc"
alias ohmyzsh=". ~/.oh-my-zsh"
export EDITOR='vim'
export VISUAL='vim'

#用户二进制程序目录
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

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

#仿fish高亮 已用plugin加载
#source ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#POWERLINE
#POWERLINE_BINDINGS=/usr/share/powerline/bindings/
#powerline-daemon -q  # run powerline daemon
#source $POWERLINE_BINDINGS/zsh/powerline.zsh

#命令建议 已用plugin加载
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
#source ${ZSH_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ${ZSH_PLUGINS_DIR}/zsh-history-substring-search/zsh-history-substring-search.zsh

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function ranger-cd {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

#fish高亮
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#将alias单独放在一起
[ -f $HOME/.zshrc-alias ] && source $HOME/.zshrc-alias

#逼格
neofetch
