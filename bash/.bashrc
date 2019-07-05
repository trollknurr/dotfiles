export EDITOR=nvim
export PAGER=less

PATH=$PATH:~/go/bin:~/.local/bin:~/Projects/flow9/bin

export PATH="$HOME/.cargo/bin:$PATH"

source ~/dotfiles/bash/.bash_git

export HISTSIZE=10000
export HISTFILESIZE=100000

export PROMPT_COMMAND="history -a; history -n"
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\n\$ '

shopt -s autocd 

alias vim='nvim'

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

source /usr/share/autoenv-git/activate.sh

complete -C /usr/bin/nomad nomad
