# .bashrc file

set -o vi

# -----------------------------------------------------------------------------
# Exports
# -----------------------------------------------------------------------------

export EDITOR="$HOME/.local/src/nvim-v0.8.3/bin/nvim"
export SCRIPT="$HOME/.local/bin"
export JOURNAL="$HOME/journal"
export ZETTELKASTEN="$HOME/zk"
export NVIM="$HOME/.config/nvim"
export TERMINAL="$HOME/.config/alacritty"

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

alias targz='tar -czvf'

# This alias enables extended regular expressions for sed, which can make it easier to write complex search and replace patterns.
# Packages
alias sed='sed -E'
alias fd='NO_COLOR=1 fd'

# Fast open
alias a="cd $TERMINAL && $EDITOR $TERMINAL/alacritty.yml"
alias n="cd $NVIM && $EDITOR $NVIM/init.lua"
alias j="cd $JOURNAL && $EDITOR $JOURNAL/README.md"
alias k="cd $ZETTELKASTEN && $EDITOR $ZETTELKASTEN/README.md"

alias ~='cd ~'
alias ..="cd .."
alias ...="cd ../.."

alias rmtar="rm -rf *.tar.gz"
alias grep="grep --color=auto --exclude-dir={.git}"
alias chmox="chmod +x *.sh"

# Changing "ls" to "exa"
#alias ls='exa -l --color=always --group-directories-first' # my preferred listing
#alias la='exa -al --color=always --group-directories-first'  # all files and dirs
#alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt="exa --tree --level=1 --color=always --group-directories-first" # tree listing
alias ltt="exa --tree --level=2 --color=always --group-directories-first" # tree listing
alias l.='exa -a | egrep "^\."'

alias c='clear'

# Navigation
alias ls="ls --color=auto"
# This alias lists all files in the current directory, including hidden files, in a long format, with additional information such as permissions and ownership
#alias ll='ls -alF'
# This alias lists all files in the current directory, including hidden files, but omits the special directories . and ...
#alias la='ls -A'
# lists all files in the current directory, in a compact format with directory contents listed first, followed by files.
#alias l='ls -CF'

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

git_unpushed() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        local unpushed_commits=$(git log --branches --not --remotes 2> /dev/null | grep -cE '^commit')
        if [[ $unpushed_commits -gt 0 ]]; then
            echo "! "
        else
            echo ""
        fi
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
${BOLD}${RED}\$(git_unpushed)${RESET}\
${YELLOW}\$(git_uncommitted)${RESET}\
${CYAN}: ${RESET}"


### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.xz)    tar xf $1    ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar)       tar xf $1    ;;
      *.gz)        gunzip $1    ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.zip)       unzip $1     ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

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
