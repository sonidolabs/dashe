#!/bin/bash
export LANG=C.UTF-8

if [ ! -d $HOME/.dashe ]; then
    mkdir $HOME/.dashe
fi

if [ ! -f $HOME/.bashrc ]; then
    touch $HOME/.bashrc
else
    cp $HOME/.bashrc $HOME/.dashe
fi

if [ ! -f $HOME/.dashe/dashe_imports.sh ]; then
    if ! curl -k -s -o $HOME/.dashe/dashe_imports.sh https://raw.githubusercontent.com/Gabriel3atista/dashe/master/src/dashe_imports.sh; then
        echo -e "\n\e[031mErro\e[0m: Download failed. Please check your internet connection or network configuration.\n"
        exit 1
    else
        curl -k -s -o $HOME/.dashe/dashe_imports.sh https://raw.githubusercontent.com/Gabriel3atista/dashe/master/src/dashe_imports.sh
    fi
fi

source $HOME/.dashe/dashe_imports.sh

if [ ! -f $HOME/.dashe/version.txt ]; then
    curl -k -s -o $HOME/.dashe/version.txt https://raw.githubusercontent.com/Gabriel3atista/dashe/master/version.txt
fi

import_aliases
import_cli
import_colors
import_utils
import_prompt
import_dialogs

if [[ -f $HOME/.bashrc && $HOME/dashe_prompt.sh && $(grep "# Dashe prompt definitions." $HOME/.bashrc) ]]; then
    echo -e "\n$(set_text_style "$green" "Dashe") $(set_text_style "$white" "is already installed") 😎\n"
    exit 0
fi

install_dialog
