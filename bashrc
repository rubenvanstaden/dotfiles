# .bashrc file

set -o vi

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
alias c='clear'
alias x='exit'

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

alias ~='cd ~'
alias ..="cd .."
alias ...="cd ../.."

alias rmtar="rm -rf *.tar.gz"
alias grep="grep --color=auto --exclude-dir={.git}"

# Changing "ls" to "exa"
alias l="exa --tree --level=1 --classify --color=never --group-directories-first" # tree listing
alias ll="exa --tree --level=2 --classify --color=never --group-directories-first" # tree listing
alias l.='exa -a | egrep "^\."'

# Navigation
alias ls="ls --color=auto"
alias lh="ls -d */ | grep -E '^[a-z]+/'"

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

source "$HOME/.zsh/z/z.sh"

current_directory() {
    if [[ $(pwd) == $HOME ]]; then
        echo "~ "
    else
        echo "$(basename $(pwd)) "
    fi
}

git_branch() {
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        echo "[$branch] "
    fi
}

git_uncommitted() {
    if [[ $(git status --porcelain 2>/dev/null) ]]; then
        echo -e "* "
    fi
}

RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
BLUE='\[\033[34m\]'
BRANCH_COLOR='\[\033[38;5;240m\]'
BOLD='\[\033[1m\]'
RESET='\[\033[00m\]'
CYAN='\[\033[36m\]'
YELLOW='\[\033[0;33m\]'

PS1="\n \$(current_directory)\
${BOLD}${BRANCH_COLOR}\$(git_branch)${RESET}\
${YELLOW}\$(git_uncommitted)${RESET}\
${CYAN}: ${RESET}"


# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

fh() {
    ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# Same as above, but allows multi selection:
drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}

# Select a docker image or images to remove
drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
