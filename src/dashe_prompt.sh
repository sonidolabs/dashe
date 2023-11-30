# !/bin/bash
source $HOME/.dashe/dashe_imports.sh

import_colors
import_utils

username='\u'
username_color=$(tput setaf 255)
separator=' '
separator_color=$(tput setaf 255)
path='\w'
path_color=$(tput setaf 255)
symbol='$'
symbol_color=$(tput setaf 255)

reset_prompt() {
    printf "%b" "${tput_reset}"
}

set_prompt() {
    branch=$(get_git_branch)
    PS1=$"\[$username_color\]\[$bold\]$username\[$tput_reset\]\[$separator_color\]$separator\[$tput_reset\]\[$path_color\]$path\[$tput_reset\]\[$separator_color\]$separator\[$tput_reset\]$branch\[$symbol_color\]$symbol\[$tput_reset\] "
}

execute_prompt() {
    reset_prompt
    set_prompt
}

execute_prompt

PROMPT_COMMAND='execute_prompt'
