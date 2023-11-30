#!/bin/bash

alias restart="source ~/.bashrc"

# system aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias rmf="rm -rf"

# git alias
alias pull="git pull origin"
alias push="git push origin"
alias add="git add"
alias adda="git add ."
alias commit="git commit -m"
alias ckout="git checkout"
alias nbranch="git checkout -b"
alias dbranch="git branch -D"

# git flow alias
alias gffs="git flow feature start"
alias gfhs="git flow hotfix start"
alias gfhp="git flow hotfix publish"
alias gffp="git flow feature publish"
alias gfff="git flow feature finish"
alias gfhf="git flow hotfix finish"