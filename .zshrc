eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ffd2,bg=#0a0047,bold"
pokemon-colorscripts --random
export PATH=$PATH:/usr/local/bin
export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/khang/google-cloud-sdk/path.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/khang/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/completion.zsh.inc'; fi

alias cava="TERM=xterm-256color cava"
