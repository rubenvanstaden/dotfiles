# -------------------------------------------------------------------------------
# Load completion system
# -------------------------------------------------------------------------------

autoload -Uz compinit
compinit

# -------------------------------------------------------------------------------
# Set auto change directory
# -------------------------------------------------------------------------------

setopt auto_cd
setopt inc_append_history
setopt share_history

# -------------------------------------------------------------------------------
# Load env variables
# -------------------------------------------------------------------------------

export JOURNAL="$HOME/journal"
export SCRIPT="$HOME/.local/bin"
export ZLIB="$HOME/zettelkasten/zlib"

# -------------------------------------------------------------------------------
# Update path variable
# -------------------------------------------------------------------------------

path+="$SCRIPT"
path+="$HOME/.cargo/bin"
path+="$HOME/go/bin"
path+="usr/local/go"

# -------------------------------------------------------------------------------
# Environment 
# -------------------------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"
export DOCKER_BUILDKIT=1

# -------------------------------------------------------------------------------
# Aliases 
# -------------------------------------------------------------------------------

alias today='date +"%A, %B %-d, %Y"'
alias hload="fc -R $HOME/.zsh_history"
alias rload="source $HOME/.zshrc"
alias rmtar="rm -rf *.tar.gz"
alias rm="rm -rf"
alias mkdir="mkdir -p"
alias grep="grep --color=auto --exclude-dir={.git}"
alias shutdown="shutdown -h now"
alias cx="chmod +x *.sh"

# Navigation
alias ll="ls -al --color=auto"
alias ls="ls --color=tty"
alias l="ls"
alias c="clear"

alias t1="tree --dirsfirst -C -L 1 ."
alias t2="tree --dirsfirst -C -L 2 ."
alias t3="tree --dirsfirst -C -L 3 ."
alias t4="tree --dirsfirst -C -L 4 ."
alias t=t1
alias tt=t2

# Configuration
alias dz="nvim $HOME/.zshrc"
alias di="nvim $HOME/.config/i3/config"
alias da="nvim $HOME/.config/alacritty/alacritty.yml"
alias dn="cd $HOME/.config/nvim && nvim"

# -------------------------------------------------------------------------------
# Plugins
# -------------------------------------------------------------------------------

# https://github.com/zsh-users/zsh-completions
fpath+="$HOME/.zsh/zsh-completions"

# https://github.com/rupa/z
source "$HOME/.zsh/z/z.sh"
# https://github.com/zsh-users/zsh-autosuggestions
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
# https://github.com/zsh-users/zsh-history-substring-search 
source "$HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"

# -------------------------------------------------------------------------------
# Command Prompt
# -------------------------------------------------------------------------------

# https://salferrarello.com/zsh-git-status-prompt/
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info

# Enable substitution in the prompt.
setopt prompt_subst

# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true

# Set custom strings for an unstaged changes (*)
zstyle ':vcs_info:*' unstagedstr ' %F{red}!%f'

# Set custom strings for staged changes (+)
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'

# Set the format of the git information for vcs_info
zstyle ':vcs_info:git:*' formats $'(%b%m%u%c%F{240})%f'

prompt=$'\n%F{white}%2~%f %B%F{240}${vcs_info_msg_0_}%f%b %F{cyan}>%f '

# # Config for prompt. PS1 synonym.
# prompt=$'%B%F{240}${vcs_info_msg_0_}%f%b\n'
# prompt+=$'%F{242}%~%f %F{cyan}>%f '

# -------------------------------------------------------------------------------
# Vim Mode
# -------------------------------------------------------------------------------

# Use vi mode
bindkey -v

# Make switch between vim modes faster
export KEYTIMEOUT=1

# Gives access to menuselect
zmodload zsh/complist

# Key bindings 
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# A visual indicator to show the current mode
cursor_block='\e[2 q'
cursor_beam='\e[6 q'

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne $cursor_block
    else
        echo -ne $cursor_beam
    fi
}

function zle-line-init {
    echo -ne $cursor_beam
}

zle -N zle-keymap-select
zle -N zle-line-init

# -------------------------------------------------------------------------------
# fzf
# -------------------------------------------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
