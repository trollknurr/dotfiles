#
# ~/.bash_profile
#



[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH="/opt/homebrew/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tonysh/.local/opt/google-cloud-sdk/path.bash.inc' ]; then . '/Users/tonysh/.local/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tonysh/.local/opt/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/tonysh/.local/opt/google-cloud-sdk/completion.bash.inc'; fi

. "$HOME/.local/bin/env"
. "$HOME/.cargo/env"
