# ==============================================================================
# Zsh 配置
# ==============================================================================
#
# 适用环境：
#   - Arch Linux
#   - Oh My Zsh: /usr/share/oh-my-zsh
#   - zsh-autosuggestions
#   - zsh-syntax-highlighting
#   - zsh-history-substring-search
#   - fzf
#   - pyenv / pyenv-virtualenv
#   - ranger
#
# 配置拆分：
#
#   .zshrc-env
#       基础环境、PATH、History、Options
#
#   .zshrc
#       主配置、Oh My Zsh、Completion、Key bindings、Prompt、Plugins
#
#   .zshrc-functions
#       自定义函数
#
#   .zshrc-alias
#       Alias
#
# core/extra:
#   git stow zsh ranger eza lsd
#
# archlinuxcn:
#   oh-my-zsh-git
#   zsh-autosuggestions
#   zsh-syntax-highlighting
#   zsh-history-substring-search
#
# AUR:
#   filkoll
#   neofetch
# ==============================================================================


# ------------------------------------------------------------------------------
# 1. Environment
# ------------------------------------------------------------------------------

source "$HOME/dotfiles/zsh/.zshrc-env"


# ------------------------------------------------------------------------------
# 2. Oh My Zsh
# ------------------------------------------------------------------------------

# 基础主题。
#
# 后面自定义 PROMPT / RPROMPT 会覆盖主题 Prompt，
# 这里保留作为基础配置。
ZSH_THEME="robbyrussell"

# Oh My Zsh 插件
plugins=(
    git
)

source "$ZSH/oh-my-zsh.sh"


# ------------------------------------------------------------------------------
# 3. Completion
# ------------------------------------------------------------------------------

# Tab 补全显示菜单
zstyle ':completion:*' menu select

# 补全命令失败时重新检查 PATH 中的可执行程序
zstyle ':completion:*' rehash true

# 使用 LS_COLORS 显示补全颜色
[[ -n "$LS_COLORS" ]] &&
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 补全时忽略大小写
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}'

# 进程补全显示 PID / 用户 / 命令
zstyle ':completion:*:processes' command \
    'ps -u $USER -o pid,user,comm -w -w'


# ------------------------------------------------------------------------------
# 4. Key bindings
# ------------------------------------------------------------------------------

# 使用 Vi 模式
bindkey -v

# 减少 ESC 从 Insert mode 切换到 Normal mode 的等待时间
KEYTIMEOUT=1


# Vi Insert mode

# Home / End
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[[F' end-of-line

# Ctrl + →
bindkey -M viins '^[[1;5C' forward-word

# Ctrl + ←
bindkey -M viins '^[[1;5D' backward-word

# Ctrl + Backspace
#
# 注意：具体 escape sequence 与 terminal emulator 有关。
bindkey -M viins '^H' backward-kill-word

# Ctrl + Delete
bindkey -M viins '^[[3;5~' kill-word


# ↑ / ↓ 的历史搜索交给 zsh-history-substring-search。


# ------------------------------------------------------------------------------
# 5. Prompt
# ------------------------------------------------------------------------------

# Oh My Zsh 已经加载颜色定义：
#
#   $fg[red]
#   $fg[green]
#   $reset_color

# root 使用 #
# 普通用户使用 $
if (( EUID == 0 )); then
    _prompt_symbol="#"
else
    _prompt_symbol="$"
fi


# 左侧：
#
#   [user@hostname directory ] $
#
# %n
#   用户名
#
# %m
#   主机名（第一个 . 之前）
#
# %1~
#   当前目录最后一级
PROMPT='%{$fg[green]%}['
PROMPT+='%{$fg[red]%}%n'
PROMPT+='%{$reset_color%}@'
PROMPT+='%{$fg[blue]%}%m '
PROMPT+='%{$fg[yellow]%}%1~'
PROMPT+=' %{$fg[green]%}]'
PROMPT+='%{$reset_color%} '"$_prompt_symbol "


# 右侧：
#
#   14:30 [0]
#
# %T
#   HH:MM
#
# %?
#   上一条命令退出状态
RPROMPT='%{$fg[green]%}%T%{$reset_color%} '
RPROMPT+='[%{$fg[yellow]%}%?%{$reset_color%}]'

unset _prompt_symbol

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

# ------------------------------------------------------------------------------
# 6. zsh-autosuggestions
# ------------------------------------------------------------------------------

# 自动建议来源：
#
# match_prev_cmd
#   根据上一条命令进行预测。
#
# history
#   从历史记录匹配。
#
# completion
#   从补全系统获取。
ZSH_AUTOSUGGEST_STRATEGY=(
    match_prev_cmd
    history
    completion
)

# 异步生成 suggestion，减少输入卡顿
ZSH_AUTOSUGGEST_USE_ASYNC=true

if [[ -r "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi


# ------------------------------------------------------------------------------
# 7. zsh-history-substring-search
# ------------------------------------------------------------------------------

if [[ -r "$ZSH_PLUGINS_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then

    source "$ZSH_PLUGINS_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

    # Vi Insert mode
    bindkey -M viins '^[[A' history-substring-search-up
    bindkey -M viins '^[[B' history-substring-search-down

    # Vi Normal mode
    bindkey -M vicmd '^[[A' history-substring-search-up
    bindkey -M vicmd '^[[B' history-substring-search-down
fi


# ------------------------------------------------------------------------------
# 8. fzf
# ------------------------------------------------------------------------------

# fzf shell integration：
#
# Ctrl-R
#   搜索 history
#
# Ctrl-T
#   搜索文件
#
# Alt-C
#   搜索目录
if [[ -r "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
fi


# ------------------------------------------------------------------------------
# 9. command-not-found
# ------------------------------------------------------------------------------

if [[ -r "/usr/share/doc/filkoll/command-not-found.zsh" ]]; then

    source "/usr/share/doc/filkoll/command-not-found.zsh"

elif [[ -r "/usr/share/doc/pkgfile/command-not-found.zsh" ]]; then

    source "/usr/share/doc/pkgfile/command-not-found.zsh"

fi


# ------------------------------------------------------------------------------
# 10. pyenv
# ------------------------------------------------------------------------------

export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT/bin" ]]; then
    path=("$PYENV_ROOT/bin" $path)
fi

if (( $+commands[pyenv] )); then

    eval "$(pyenv init - zsh)"

    if [[ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]]; then
        eval "$(pyenv virtualenv-init - zsh)"
    fi
fi


# ------------------------------------------------------------------------------
# 11. Functions
# ------------------------------------------------------------------------------

[[ -r "$ZDOTDIR/.zshrc-functions" ]] &&
    source "$ZDOTDIR/.zshrc-functions"


# ------------------------------------------------------------------------------
# 12. Alias
# ------------------------------------------------------------------------------

[[ -r "$ZDOTDIR/.zshrc-alias" ]] &&
    source "$ZDOTDIR/.zshrc-alias"


# ------------------------------------------------------------------------------
# 13. 可选：系统信息
# ------------------------------------------------------------------------------

# 不建议默认开启，
# 因为每次打开终端都会增加启动耗时。
#
# if [[ -o interactive ]] && (( $+commands[fastfetch] )); then
#     fastfetch
# fi


# ------------------------------------------------------------------------------
# 14. zsh-syntax-highlighting
# ------------------------------------------------------------------------------

# 尽量保持为 .zshrc 最后加载的插件。
#
# 后面不要再加载会修改 ZLE widget/key binding 的插件。
if [[ -r "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


# ==============================================================================
# END
# ==============================================================================
