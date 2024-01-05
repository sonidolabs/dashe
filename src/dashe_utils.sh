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
    curl -k -s -o $HOME/.dashe/dashe_colors.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_colors.sh
    curl -k -s -o $HOME/.dashe/dashe_aliases.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_aliases.sh
    curl -k -s -o $HOME/.dashe/dashe_cli.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_cli.sh
    curl -k -s -o $HOME/.dashe/dashe_dialogs.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_dialogs.sh
    curl -k -s -o $HOME/.dashe/dashe_prompt.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_prompt.sh
    curl -k -s -o $HOME/.dashe/dashe_utils.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_utils.sh

    printf "\n$(set_text_style "$white" "Your") $dashe $(set_text_style "$white" "has been updated!")\n"
    printf "\n$(set_text_style "$white" "Current version:") $(set_text_style "$green" "$LATEST_VERSION")\n\n"
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
    local version=$(curl -k --silent "https://d7uyonffhkqkw.cloudfront.net/dashe/version.txt")
    
    if [[ "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$version"
    else
        echo -e "$(set_text_style "$red" "Failed to retrieve the latest version.")"
    fi
}

dashe_help() {
    printf "\n$(set_text_style "$green" "Command")                                           $(set_text_style "$green" "Description")\n"
    printf "\n$(set_text_style "$yellow" "--help")                                            $(set_text_style "$white" "Show all helps and commands.")\n"
    printf "$(set_text_style "$yellow" "--version")                                         $(set_text_style "$white" "Show current version.")\n"
    printf "$(set_text_style "$yellow" "--update")                                          $(set_text_style "$white" "Update all scripts and files.")\n"
    printf "$(set_text_style "$yellow" "--uninstall")                                       $(set_text_style "$white" "Uninstall the Dashe.")\n"
    printf "$(set_text_style "$yellow" "--replace-alias-name <old name> <new name>")        $(set_text_style "$white" "Replaces an existing alias name.")\n"
    printf "$(set_text_style "$yellow" "--replace-alias-value <old value> <new value>")     $(set_text_style "$white" "Replaces an existing alias value.")\n"
    printf "$(set_text_style "$yellow" "--set-username <username>")                         $(set_text_style "$white" "Sets the prompt username.")\n"
    printf "$(set_text_style "$yellow" "--set-alias <alias> <command>")                     $(set_text_style "$white" "Set a new alias.")\n"
    printf "$(set_text_style "$yellow" "--set-separator <separator>")                       $(set_text_style "$white" "Sets the prompt user separator.")\n"
    printf "$(set_text_style "$yellow" "--set-path")                                        $(set_text_style "$white" "Defines the folder path.")\n"
    printf "$(set_text_style "$yellow" "--set-symbol <symbol>")                             $(set_text_style "$white" "Defines the symbol character.")\n"
    printf "$(set_text_style "$yellow" "--set-username-color <color>")                      $(set_text_style "$white" "Sets the color of the username.")\n"
    printf "$(set_text_style "$yellow" "--set-separator-color <color>")                     $(set_text_style "$white" "Sets the color of the separator.")\n"
    printf "$(set_text_style "$yellow" "--set-path-color <color>")                          $(set_text_style "$white" "Sets the color of the path.")\n"
    printf "$(set_text_style "$yellow" "--set-symbol-color <color>")                        $(set_text_style "$white" "Sets the color of the symbol character.")\n"
    printf "$(set_text_style "$yellow" "--all-colors")                                      $(set_text_style "$white" "Renders all available colors.")\n"
    printf "$(set_text_style "$yellow" "--aliases")                                         $(set_text_style "$white" "Show all aliases.")\n\n"
}

show_aliases() {
    printf "\n$(set_text_style "$white" "System ------------------------------------")\n"
    printf "\n$(set_text_style "$green" "Alias")         $(set_text_style "$green" "Command")\n"
    printf "$(set_text_style "$yellow" "restart")       $(set_text_style "$white" "source ~/.bashrc")\n"
    printf "$(set_text_style "$yellow" "ll")            $(set_text_style "$white" "ls -alF")\n"
    printf "$(set_text_style "$yellow" "la")            $(set_text_style "$white" "ls -A")\n"
    printf "$(set_text_style "$yellow" "l")             $(set_text_style "$white" "ls -CF")\n"
    printf "$(set_text_style "$yellow" "rmf")           $(set_text_style "$white" "rm -rf")\n"
    printf "\n$(set_text_style "$white" "Git ---------------------------------------")\n"
    printf "\n$(set_text_style "$green" "Alias")         $(set_text_style "$green" "Command")\n"
    printf "$(set_text_style "$yellow" "pull")          $(set_text_style "$white" "git pull origin")\n"
    printf "$(set_text_style "$yellow" "push")          $(set_text_style "$white" "git push origin")\n"
    printf "$(set_text_style "$yellow" "merge")         $(set_text_style "$white" "git merge")\n"
    printf "$(set_text_style "$yellow" "add")           $(set_text_style "$white" "git add")\n"
    printf "$(set_text_style "$yellow" "adda")          $(set_text_style "$white" "git add .")\n"
    printf "$(set_text_style "$yellow" "commit")        $(set_text_style "$white" "git commit -m")\n"
    printf "$(set_text_style "$yellow" "ckout")         $(set_text_style "$white" "git checkout")\n"
    printf "$(set_text_style "$yellow" "nbranch")       $(set_text_style "$white" "git checkout -b")\n"
    printf "$(set_text_style "$yellow" "dbranch")       $(set_text_style "$white" "git branch -D")\n"
    printf "$(set_text_style "$yellow" "addro")         $(set_text_style "$white" "git remote add origin")\n"
    printf "\n$(set_text_style "$white" "Git Flow ----------------------------------")\n"
    printf "\n$(set_text_style "$green" "Alias")         $(set_text_style "$green" "Command")\n"
    printf "$(set_text_style "$yellow" "gffs")          $(set_text_style "$white" "git flow feature start")\n"
    printf "$(set_text_style "$yellow" "gfhs")          $(set_text_style "$white" "git flow hotfix start")\n"
    printf "$(set_text_style "$yellow" "gfhp")          $(set_text_style "$white" "git flow hotfix publish")\n"
    printf "$(set_text_style "$yellow" "gffp")          $(set_text_style "$white" "git flow feature publish")\n"
    printf "$(set_text_style "$yellow" "gfff")          $(set_text_style "$white" "git flow feature finish")\n"
    printf "$(set_text_style "$yellow" "gfhf")          $(set_text_style "$white" "git flow hotfix finish")\n\n"
}

success_message() {
    printf "\n$(set_text_style "$white" "Welcome to") $dashe\n"
    printf "\n$(set_text_style "$white" "If you would like to customize your prompt, please visit") $(set_text_style "$blue" "https://github.com/sonidolabs/dashe") $(set_text_style "$white" "for instructions!")\n"
    printf "\n$(set_text_style "$white" "To see all commands, type") $(set_text_style "$yellow" "dashe --help")$(set_text_style "$white" "!")\n"
    printf "\n$(set_text_style "$white" "Hope you enjoy - version") $(set_text_style "$green" "$(get_latest_release)\n\n")"
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

        import_aliases
        
    fi
}

set_bash() {
    cli_alias_script="# Dashe cli definitions.
        alias dashe='$HOME/.dashe/dashe_cli.sh'"

    prompt_file_script="# Dashe prompt definitions.
        if [ -f $HOME/.dashe/dashe_prompt.sh ]; then
            . $HOME/.dashe/dashe_prompt.sh
        fi"

    version_verification="# Dashe version verification.
        if [[ $CURRENT_VERSION != $LATEST_VERSION ]]; then
            import_dialogs
            version_dialog
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

set_alias() {
    # Check if has two args
    if [ $# -ne 2 ]; then
        printf "\n$(set_text_style "$yellow" "Please enter a valid alias and value")\n"
        printf "\n$(set_text_style "$yellow" "Example:") $(set_text_style "$white" "dashe --set-alias logs \"git log\"")\n\n"
        return 1
    fi
    
    new_alias="alias $1=\"$2\""

    if [ ! -f $HOME/.dashe/dashe_aliases.sh ]; then
        touch $HOME/.dashe/dashe_aliases.sh
    fi

    printf "\n$new_alias" >> $HOME/.dashe/dashe_aliases.sh

    printf "\n$(set_text_style "$white" "Alias") $(set_text_style "$yellow" "$1") $(set_text_style "$white" "created successfully!")\n\n"

    exec bash
}

replace_alias_name() {
    local aliases_file="$HOME/.dashe/dashe_aliases.sh"

    if grep -q "^alias $1=" "$aliases_file" 2>/dev/null; then
        sed -i "s/^alias $1=/alias $2=/" "$aliases_file"
    else
        printf "\n$(set_text_style "$white" "Alias") $(set_text_style "$yellow" "$1") $(set_text_style "$white" "not found!")\n\n"
    fi

    exec bash
}

replace_alias_value() {
    local aliases_file="$HOME/.dashe/dashe_aliases.sh"

    if grep -q "^alias $1=" "$aliases_file" 2>/dev/null; then
        sed -i "s/^alias $1=.*/alias $1=\"$2\"/" "$aliases_file"
    else
        printf "\nalias $1=\"$2\"" >> "$aliases_file"
    fi

    exec bash
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