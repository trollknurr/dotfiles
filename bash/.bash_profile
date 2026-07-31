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

# Created by `pipx` on 2026-07-01 15:21:00
export PATH="$PATH:/Users/anton.shtarev/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anton.shtarev/Projects/mY/google-cloud-sdk/path.bash.inc' ]; then . '/Users/anton.shtarev/Projects/mY/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anton.shtarev/Projects/mY/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/anton.shtarev/Projects/mY/google-cloud-sdk/completion.bash.inc'; fi
