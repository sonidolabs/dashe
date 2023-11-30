#!/bin/bash
source $HOME/.dashe/dashe_imports.sh

import_colors

set_text_style() {
    local text="$1$2$tput_reset"

    printf "$text"
}

dashe=$(set_text_style "$violet_1" "Da")$(set_text_style "$violet_2" "s")$(set_text_style "$lilac_1" "h")$(set_text_style "$lilac_2" "e")

is_number() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

update() {
    import_colors
    import_dialogs
    import_utils
    import_cli
    import_aliases
    import_prompt

    if [[ $CURRENT_VERSION != $LATEST_VERSION ]]; then
        echo $LATEST_VERSION > $HOME/.dashe/version.txt
        printf "\n$(set_text_style "$white" "Your") $dashe $(set_text_style "$white" "has been updated!")\n"
        printf "\n$(set_text_style "$white" "Current version:") $(set_text_style "$green" "$LATEST_VERSION")\n\n"
    else
        printf "\n$(set_text_style "$white" "You are updated!")\n"
        printf "\n$dashe $(set_text_style "$white" "version —") $(set_text_style "$green" "$LATEST_VERSION")\n\n"
    fi
}

uninstall() {
    import_dialogs
    uninstall_dialog
}

colors256() {
    local c i j

    printf "Colors 0 to 15 for the standard 16 colors\n"
    for ((c = 0; c < 16; c++)); do
            printf " |%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n\n"

    printf "Colors 16 to 231 for 256 colors\n"
    for ((i = j = 0; c < 232; c++, i++)); do
            printf "|"
            ((i > 5 && (i = 0, ++j))) && printf " |"
            ((j > 5 && (j = 0, 1)))   && printf "\b \n|"
            printf "%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n\n"

    printf "Greyscale 232 to 255 for 256 colors\n"
    for ((; c < 256; c++)); do
            printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n"
}

get_latest_release() {
    local response=$(curl -k --silent "https://api.github.com/repos/Gabriel3atista/dashe/releases")
    local version=$(echo "$response" | grep -m1 -oP '"tag_name": "\K[^"]+')
    
    if [ -n "$version" ]; then
        echo "$version"
    else
        echo -e "$(set_text_style "$red" "Failed to retrieve the latest version.")"
    fi
}

dashe_help() {
    printf "\n$(set_text_style "$green" "Command")                       $(set_text_style "$green" "Description")\n"
    printf "\n$(set_text_style "$yellow" "--version")                     $(set_text_style "$white" "Show current version.")\n"
    printf "$(set_text_style "$yellow" "--update")                      $(set_text_style "$white" "Update all scripts and files.")\n"
    printf "$(set_text_style "$yellow" "--uninstall")                   $(set_text_style "$white" "Uninstall the Dashe.")\n"
    printf "$(set_text_style "$yellow" "--set-username")                $(set_text_style "$white" "Sets the prompt username.")\n"
    printf "$(set_text_style "$yellow" "--set-separator")               $(set_text_style "$white" "Sets the prompt user separator.")\n"
    printf "$(set_text_style "$yellow" "--set-path")                    $(set_text_style "$white" "Defines the folder path.")\n"
    printf "$(set_text_style "$yellow" "--set-symbol")                  $(set_text_style "$white" "Defines the symbol character.")\n"
    printf "$(set_text_style "$yellow" "--set-username-color")          $(set_text_style "$white" "Sets the color of the username.")\n"
    printf "$(set_text_style "$yellow" "--set-separator-color")         $(set_text_style "$white" "Sets the color of the separator.")\n"
    printf "$(set_text_style "$yellow" "--set-path-color")              $(set_text_style "$white" "Sets the color of the path.")\n"
    printf "$(set_text_style "$yellow" "--set-symbol-color")            $(set_text_style "$white" "Sets the color of the symbol character.")\n"
    printf "$(set_text_style "$yellow" "--all-colors")                  $(set_text_style "$white" "Renders all available colors.")\n"
    printf "$(set_text_style "$yellow" "--help")                        $(set_text_style "$white" "Show all helps and commands.")\n\n"
}

get_aliases_file() {
    curl -k -s -o $HOME/.dashe/dashe_aliases.sh https://raw.githubusercontent.com/Gabriel3atista/dashe/master/src/dashe_aliases.sh
}

success_message() {
    printf "\n$(set_text_style "$white" "Welcome to") $dashe\n"
    printf "\n$(set_text_style "$white" "If you would like to customize your prompt, please visit") $(set_text_style "$blue" "https://github.com/Gabriel3atista/dashe") $(set_text_style "$white" "for instructions!")\n"
    printf "\n$(set_text_style "$white" "To see all commands, type") $(set_text_style "$yellow" "dashe --help")$(set_text_style "$white" "!")\n"
    printf "\n$(set_text_style "$white" "Hope you enjoy — version") $(set_text_style "$green" "v1.0\n\n")"
}

get_git_branch() {
    # check if the current directory is a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local current_branch=$(git symbolic-ref --short HEAD)

        case $current_branch in
            "master" | "main" | "develop")
                current_branch="\[$red\]$(git symbolic-ref --short HEAD)\[$tput_reset\]"
                ;;
            *)
                current_branch="\[$yellow\]$(git symbolic-ref --short HEAD)\[$tput_reset\]"
                ;;
        esac
        
        # check if a branch exists
        if [[ -n $current_branch ]]; then
            # check if files have been changed or files are untracked
            if [[ -n $(git diff) || -n $(git ls-files --others --exclude-standard) ]]; then
                printf "($current_branch \[$red\]●\[$tput_reset\]) "
                return
            # check if files are in the stage area
            elif [[ -n $(git diff --cached --name-only) ]]; then
                printf "($current_branch \[$yellow\]●\[$tput_reset\]) "
                return
            # check if have files to push
            elif [[ -n $(git log --branches --not --remotes) ]]; then
                printf "($current_branch \[$green\]●\[$tput_reset\]) "
                return
            # nothing to commit
            else
                printf "($current_branch \[$white\]●\[$tput_reset\]) "
                return
            fi
        fi
    fi
}

set_aliases() {
    if [[ ! $(grep "# Dashe aliases definitions." $HOME/.bashrc) ]]; then
        aliases_file_script="# Dashe aliases definitions.
        if [ -f $HOME/.dashe/dashe_aliases.sh ]; then
            . $HOME/.dashe/dashe_aliases.sh
        fi"

        set_aliases_file=$(echo "$aliases_file_script" | sed 's/^[ \t]*//')

        if [[ -f $HOME/.bashrc ]]; then
            if [ -s $HOME/.bashrc ]; then
                echo -e "\n$set_aliases_file" >> $HOME/.bashrc
            else
                echo "$set_aliases_file" >> $HOME/.bashrc
            fi
        else
            echo "$set_aliases_file" >> $HOME/.bashrc
        fi

        get_aliases_file
        
    fi
}

set_bash() {
    cli_alias_script="# Dashe cli definitions.
        alias dashe='$HOME/.dashe/dashe_cli.sh'"

    prompt_file_script="# Dashe prompt definitions.
        if [ -f $HOME/.dashe/dashe_prompt.sh ]; then
            . $HOME/.dashe/dashe_prompt.sh
        fi"

    set_cli_alias=$(echo "$cli_alias_script" | sed 's/^[ \t]*//')
    set_prompt_file=$(echo "$prompt_file_script" | sed 's/^[ \t]*//')

    if [ -s $HOME/.bashrc ]; then
        echo -e "\n$set_cli_alias" >> $HOME/.bashrc
        echo -e "\n$set_prompt_file" >> $HOME/.bashrc
        success_message
        exec bash
    else
        echo "$set_cli_alias" >> $HOME/.bashrc
        echo "$set_prompt_file" >> $HOME/.bashrc
        success_message
        exec bash
    fi
}

set_username() {
    if [ -n "$1" ]; then
        import_prompt
        sed -i "s/username=.*/username='$1'/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "Please enter a valid username")\n\n"
    fi
}

set_username_color() {
    if [[ -n "$1" && "$1" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        import_prompt
        sed -i "s/username_color=\$(tput setaf [0-9]\+)/username_color=\$(tput setaf $1)/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "$1") $(set_text_style "$white" "is not a valid color.")\n"
        printf "\n$(set_text_style "$white" "To see all color, type") $(set_text_style "$yellow" "dashe --all-colors") $(set_text_style "$white" "command!")\n\n"
    fi
}

set_separator() {
    if [ -n "$1" ]; then
        import_prompt
        sed -i "s/separator=.*/separator='$1'/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "Please enter a valid separator")\n\n"
    fi
}

set_separator_color() {
    if [[ -n "$1" && "$1" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        import_prompt
        sed -i "s/separator_color=\$(tput setaf [0-9]\+)/separator_color=\$(tput setaf $1)/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "$1") $(set_text_style "$white" "is not a valid color.")\n"
        printf "\n$(set_text_style "$white" "To see all color, type") $(set_text_style "$yellow" "dashe --all-colors") $(set_text_style "$white" "command!")\n\n"
    fi
}

set_path_color() {
    if [[ -n "$1" && "$1" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        import_prompt
        sed -i "s/path_color=\$(tput setaf [0-9]\+)/path_color=\$(tput setaf $1)/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "$1") $(set_text_style "$white" "is not a valid color.")\n"
        printf "\n$(set_text_style "$white" "To see all color, type") $(set_text_style "$yellow" "dashe --all-colors") $(set_text_style "$white" "command!")\n\n"
    fi
}

set_symbol() {
    if [ -n "$1" ]; then
        import_prompt
        sed -i "s/symbol=.*/symbol='$1'/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "Please enter a valid username")\n\n"
    fi
}

set_symbol_color() {
    if [[ -n "$1" && "$1" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        import_prompt
        sed -i "s/symbol_color=\$(tput setaf [0-9]\+)/symbol_color=\$(tput setaf $1)/" "$HOME/.dashe/dashe_prompt.sh"
    else
        printf "\n$(set_text_style "$yellow" "$1") $(set_text_style "$white" "is not a valid color.")\n"
        printf "\n$(set_text_style "$white" "To see all color, type") $(set_text_style "$yellow" "dashe --all-colors") $(set_text_style "$white" "command!")\n\n"
    fi
}

if [ -f $HOME/.dashe/version.txt ]; then
    CURRENT_VERSION=$(cat $HOME/.dashe/version.txt)
else
    CURRENT_VERSION="$(set_text_style "$white" "Error getting version")"
fi
LATEST_VERSION=$(get_latest_release)

show_version() {
    if [[ $CURRENT_VERSION != $LATEST_VERSION ]]; then
        import_dialogs
        version_dialog
    else
        printf "\n$dashe $(set_text_style "$white" "version — $CURRENT_VERSION")\n\n"
    fi
}