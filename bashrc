# .bashrc file

set -o vi

export ZK="$HOME/zk"
export ZC="$HOME/zc"
export JOURNAL="$HOME/journal"
export SCRIPT="$HOME/.local/bin"
export EDITOR="$HOME/.local/bin/nv"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias ls='ls --color=auto'

# This alias lists all files in the current directory, including hidden files, in a long format, with additional information such as permissions and ownership
alias ll='ls -alF'

# This alias lists all files in the current directory, including hidden files, but omits the special directories . and ...
alias la='ls -A'

# lists all files in the current directory, in a compact format with directory contents listed first, followed by files.
alias l='ls -CF'

# This alias enables extended regular expressions for sed, which can make it easier to write complex search and replace patterns.
alias sed='sed -E'


alias e=$EDITOR
alias j="cd $JOURNAL && $EDITOR $JOURNAL/README.md"
alias ..="cd .."
alias ...="cd ../.."

alias today='date +"%A, %B %-d, %Y"'
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
alias da="nvim $HOME/.config/alacritty/alacritty.yml"
alias dn="cd $HOME/.config/nvim && nvim"

# -----------------------------------------------------------------------------
# Path
# -----------------------------------------------------------------------------

export PATH=$PATH:"$SCRIPT"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/go/bin"
export PATH=$PATH:"usr/local/go"
export PATH=$PATH:"/opt/homebrew/bin"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/.zsh/z/z.sh"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#git_branch() {
#    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
#        git branch --no-color 2> /dev/null | sed -E '/^[^*]/d; s/\* (.*)/ (\1)/'
#    fi
#}

current_directory() {
    if [[ $(pwd) == $HOME ]]; then
        echo "~ "
    else
        echo "$(basename $(pwd)) "
    fi
}

git_branch() {
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        echo -e "[$branch] "
    fi
}

git_staging() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        local unstaged_count=$(git status -s | grep -cE '^(\?\?| M)')
        local staging_count=$(git status -s | grep -cE '^(M|A)')
        if [[ $staging_count -gt 0 || $unstash_count -gt 0 ]]; then
            echo "${unstaged_count}:${staging_count} "
        else
            echo ""
        fi
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
YELLOW='\033[0;33m'

export PS1="\n \$(current_directory)\
${BOLD}${BRANCH_COLOR}\$(git_branch)${RESET}\
${GREEN}\$(git_staging)${RESET}\
${BOLD}${RED}\$(git_unpushed)${RESET}\
${YELLOW}\$(git_uncommitted)${RESET}\
${CYAN}: ${RESET}"
