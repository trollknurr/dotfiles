export EDITOR=vim
export PAGER=less

source ~/.bash_git

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\n\$ '

shopt -s autocd 

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'

alias gs='git status'
alias gco='git checkout'
alias ga='git add'
alias gcb='git checkout -b'
alias gc='git commit'
alias gup='git pull --tags --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias ggpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias glg='git log --oneline -n 20'

eval "$(/opt/homebrew/bin/direnv hook bash)"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi

