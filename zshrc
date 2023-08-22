# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:/Users/michaelcao/nvim-macos/bin"
# export PATH="$PATH:/Users/michaelcao/Developer/flutter/bin"
# export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
eval "$(pyenv init -)"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/michaelcao/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/michaelcao/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/michaelcao/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/michaelcao/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/usr/local/opt/ruby/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michaelcao/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/michaelcao/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michaelcao/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/michaelcao/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/Users/michaelcao/.local/bin:$PATH"
export PATH="$PATH:/Users/michaelcao/arcanist/bin/"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


source /Users/michaelcao/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias gt='git clone'
alias gs='git status'
alias gm='git commit -m'
alias gc='git clean'
alias gr='git restore'
alias ga='git add .'
alias gp='git push'
alias gam='git commit -am'
alias gre='git rebase'
alias gau='git add -u'
alias home='cd ~'
alias vim='nvim'

