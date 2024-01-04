#!/bin/bash
source $HOME/.dashe/dashe_imports.sh

import_colors
import_utils

declare -A commands

commands["--version"]=show_version
commands["--update"]=update
commands["--uninstall"]=uninstall
commands["--aliases"]=show_aliases
commands["--help"]=dashe_help
commands["--set-alias"]=set_alias
commands["--set-username"]=set_username
commands["--set-username-color"]=set_username_color
commands["--set-separator"]=set_separator
commands["--set-separator-color"]=set_separator_color
commands["--set-path"]=set_path
commands["--set-path-color"]=set_path_color
commands["--set-symbol"]=set_symbol
commands["--set-symbol-color"]=set_symbol_color
commands["--replace-alias-name"]=replace_alias_name
commands["--replace-alias-value"]=replace_alias_value
commands["--all-colors"]=colors256

dashe() {
    if [ $# -ge 0 ]; then
        if [[ -v commands["$1"] ]]; then
            ${commands["$1"]} "$2"
            exec bash
        else
            printf "\n$(set_text_style "$yellow" "Please enter a valid command")\n"
            printf "\n$(set_text_style "$white" "To see all commands, type") $(set_text_style "$yellow" "dashe --help")$(set_text_style "$white" "!")\n\n"
        fi
    else
        printf "\n$(set_text_style "$yellow" "No function argument provided.")\n\n"
    fi
}

dashe "$@"