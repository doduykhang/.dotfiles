eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ffd2,bg=#0a0047,bold"
pokemon-colorscripts --no-title --random

#PATH
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/$USER/go/bin
export PATH=$PATH:/home/$USER/bin
export PATH=$PATH:/home/$USER/.tmuxifier/bin

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/khang/google-cloud-sdk/path.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/khang/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/completion.zsh.inc'; fi

alias cava="TERM=xterm-256color cava"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source /usr/share/nvm/init-nvm.sh
