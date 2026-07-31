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
alias gup='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias ggpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias glg='git log --oneline -n 20'

. "$HOME/.local/bin/env"
eval "$(/opt/homebrew/bin/direnv hook bash)"

. "$HOME/.cargo/env"
source -- ~/.local/share/blesh/ble.sh
eval "$(atuin init bash)"

export K9S_CONFIG_DIR="$HOME/.config/k9s"
eval "$(atuin init bash)"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

# Created by `pipx` on 2026-07-01 15:21:00
export PATH="$PATH:/Users/anton.shtarev/.local/bin"

export UV_INDEX_ZALANDO_USERNAME=ashtarev
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

opencode() {
  export ZLLM_API_KEY="$(ztoken)"
  command opencode "$@"
}
