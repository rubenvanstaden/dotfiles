# -------------------------------------------------------------------------------
# Load completion system
# -------------------------------------------------------------------------------

autoload -Uz compinit
compinit

# -------------------------------------------------------------------------------
# Set auto change directory
# -------------------------------------------------------------------------------

setopt auto_cd

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

# -----------------------------------------------------------------------------
# Exports
# -----------------------------------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export EDITOR="$HOME/.local/src/nvim-v0.8.3/bin/nvim"
export SCRIPT="$HOME/.local/bin"
export JOURNAL="$HOME/journal"
export ZETTELKASTEN="$HOME/zk"
export SK="$HOME/sk"
export BROWSER='DuckDuckGo'

# -----------------------------------------------------------------------------
# Path
# -----------------------------------------------------------------------------

export PATH=$PATH:"$SCRIPT"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/go/bin"
export PATH=$PATH:"usr/local/go"
export PATH=$PATH:"/opt/homebrew/bin"

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------

alias e=$EDITOR
alias x='exit'
alias c='clear'

alias rc="$EDITOR $HOME/.zshrc"

alias an="ZETTELKASTEN=$HOME/archive zn"
alias al="ZETTELKASTEN=$HOME/archive zl"

alias targz='tar -czvf'

# This alias enables extended regular expressions for sed, which can make it easier to write complex search and replace patterns.
# Packages
alias sed='sed -E'
alias fd='NO_COLOR=1 fd'

# Fast open
alias a="cd $TERMINAL && $EDITOR $TERMINAL/alacritty.yml"
alias n="cd $XDG_CONFIG_HOME/nvim && $EDITOR $XDG_CONFIG_HOME/nvim/init.lua"
alias j="cd $JOURNAL && $EDITOR $JOURNAL/README.md"
alias k="cd $ZETTELKASTEN && $EDITOR $ZETTELKASTEN/README.md"

alias rmtar="rm -rf *.tar.gz"
alias grep="grep --color=auto --exclude-dir={.git}"

alias ls="ls --color=auto"
alias lh="ls -d */ | grep -E '^[a-z]+/'"
alias l="exa --tree --level=1 --classify --color=never --group-directories-first" # tree listing
alias ll="exa --tree --level=2 --classify --color=never --group-directories-first" # tree listing

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
# Prompt
# -------------------------------------------------------------------------------

# https://salferrarello.com/zsh-git-status-prompt/
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substitution, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info

# Enable substitution in the prompt.
setopt prompt_subst

# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true

# Set custom strings for an unstaged changes (*)
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}*%f'

# Set custom strings for staged changes (+)
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'

# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats  '[%b]%u%c'

prompt=$'\n%1~ %B%F{240}${vcs_info_msg_0_}%f%b %F{cyan}:%f '

# -------------------------------------------------------------------------------
# Vim Mode
# -------------------------------------------------------------------------------

# Use vi mode
bindkey -v

# Make switch between vim modes faster
export KEYTIMEOUT=1

# -------------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fh - repeat history
fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
