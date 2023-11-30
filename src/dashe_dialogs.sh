#!/bin/bash

source $HOME/.dashe/dashe_imports.sh

import_colors
import_utils

install_dialog() {
    x=0
    while [ $x = 0 ] 
    do
        printf "\n$(set_text_style "$white" "Do you want aliases? ")"
        printf "\n$(set_text_style "$white" "Alias example: ") Type 'push' to run 'git push origin'\n"
        printf "$(set_text_style "$white" "\nType your option") $(set_text_style "$yellow" "(y/n)")$(set_text_style "$white" ": ")"
        read answer

        case "$answer" in
            y)
                clear
                set_aliases
                set_bash
                x=1
                ;;
            n)
                clear
                set_bash
                x=1
                ;;
            *)
                printf "\n$(set_text_style "$red" "Error")$(set_text_style "$white" ": $REPLY") is a invalid option!"
                ;;
        esac
    done
}

uninstall_dialog() {
    printf "\n$(set_text_style "$white" "Are you sure you want to uninstall") $dashe$(set_text_style "$white" "?") $(set_text_style "$yellow" "(y/n)")$(set_text_style "$white" ": ")"
    x=0
    while [ $x = 0 ] 
    do
        read answer

        case "$answer" in
            y)
                rm $HOME/.bashrc
                cp $HOME/.dashe/.bashrc $HOME/
                rm -rf $HOME/.dashe
                clear
                printf "\n$(set_text_style "$white" "See you next time...")\n"
                printf "\n$(set_text_style "$white" "Feel free to help and") $(set_text_style "$yellow" "★ star") $(set_text_style "$white" "us on github (")$(set_text_style "$blue" "https://github.com/Gabriel3atista/dashe")$(set_text_style "$white" ")")\n\n"
                exec bash
                x=1
                ;;
            n)
                printf "\n$(set_text_style "$white" "Glad you prefer to keep") $dashe $(set_text_style "$white" "installed :)")\n\n"
                x=1
                ;;
            *)
                printf "\n$(set_text_style "$red" "Error")$(set_text_style "$white" ": $answer") is a invalid option!\n"
                ;;
        esac
    done
}

version_dialog() {
    printf "\n$dashe $(set_text_style "$white" "version — $CURRENT_VERSION")\n"
    printf "\n$(set_text_style "$yellow" "Notice")\n"
    printf "\n$(set_text_style "$white" "It looks like there is an update available!")"
    printf "\n$(set_text_style "$white" "Latest version:") $(set_text_style "$green" "$LATEST_VERSION")\n"
    x=0
    while [ $x = 0 ] 
    do
        printf "\n$(set_text_style "$white" "Do you want to update?") $(set_text_style "$yellow" "(y/n)")$(set_text_style "$white" ": ")"
        read answer

        case "$answer" in
            y)
                update
                x=1
                ;;
            n)
                x=1
                ;;
            *)
                printf "\n$(set_text_style "$red" "Error")$(set_text_style "$white" ": $answer") is a invalid option!\n"
                ;;
        esac
    done
}