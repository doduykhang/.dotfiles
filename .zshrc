eval "$(starship init zsh)"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ffd2,bg=#0a0047,bold"
pokemon-colorscripts --random

#PATH
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/$USER/go/bin
export PATH=$PATH:/home/$USER/bin
export PATH=$PATH:/home/$USER/.tmuxifier/bin
export PATH=$PATH:/home/khang/Android/Sdk/platform-tools/
export PATH=$PATH:/home/khang/Android/Sdk/tools

export MYVIMRC=/home/$USER/.config/nvim/init.lua

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/khang/google-cloud-sdk/path.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/khang/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/khang/google-cloud-sdk/completion.zsh.inc'; fi

alias cava="TERM=xterm-256color cava"

eval "$(sheldon source)"

source /usr/share/nvm/init-nvm.sh
