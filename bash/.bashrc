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
alias gup='git pull --rebase'
alias ggpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias glg='git log --oneline -n 20'
export PATH="/Users/tonysh/bin:$PATH";

. "$HOME/.local/bin/env"
eval "$(/opt/homebrew/bin/direnv hook bash)"

export KUBECONFIG="$HOME/.kube/xh-config"
. "$HOME/.cargo/env"
source -- ~/.local/share/blesh/ble.sh
eval "$(atuin init bash)"

export K9S_CONFIG_DIR="$HOME/.config/k9s"
