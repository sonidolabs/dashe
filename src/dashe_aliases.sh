#!/bin/bash

# system
alias restart="source ~/.bashrc"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias rmf="rm -rf"

# git
alias pull="git pull origin"
alias push="git push origin"
alias merge="git merge"
alias add="git add"
alias adda="git add ."
alias commit="git commit -m"
alias ckout="git checkout"
alias nbranch="git checkout -b"
alias dbranch="git branch -D"
alias addro="git remote add origin"

# git flow
alias gffs="git flow feature start"
alias gfhs="git flow hotfix start"
alias gfhp="git flow hotfix publish"
alias gffp="git flow feature publish"
alias gfff="git flow feature finish"
alias gfhf="git flow hotfix finish"

# custom