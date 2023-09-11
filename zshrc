# ====================================
#    Michael Cao's .zshrc config
# ====================================

# ------------------------------------
#        Instant Prompt
# ------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------
#       Exports, Sources, Setup 
# ------------------------------------

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add sqlite to path
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# Fix brew doctor warning for pyenv
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# Add Arcanist to path
# export PATH="$PATH:/Users/michaelcao/arcanist/bin/"

# nvm setup
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# zsh syntax highlighting
source /Users/michael/tools/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# zsh autocomplete
# source /Users/michael/tools/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# zsh autosuggestions
source /Users/michael/tools/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# powerlevel10k setup
source ~/tools/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------
#        Aliases
# ------------------------------------

alias gs='git status'
alias gcl='git clone'
alias gcom='git commit -m'
alias gcam='git commit -am'
alias gch='git checkout'
alias gr='git restore'
alias ga='git add'
alias gp='git push'
alias gre='git rebase'
alias gau='git add -u'

alias home='cd ~'
alias vim='nvim'

# ------------------------------------
#        zsh Vim mode
# ------------------------------------

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

# ------------------------------------
#        Additional Config
# ------------------------------------

bindkey -r '\e\[3~'

# export nvm_dir="$home/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # this loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # this loads nvm bash_completion


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="/usr/local/opt/ruby/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/michaelcao/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/michaelcao/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/michaelcao/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/michaelcao/google-cloud-sdk/completion.zsh.inc'; fi

