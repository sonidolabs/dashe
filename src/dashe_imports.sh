#!/bin/bash

import_aliases() {
  if [ ! -f $HOME/.dashe/dashe_aliases.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_aliases.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_aliases.sh
  fi

  source $HOME/.dashe/dashe_aliases.sh
}

import_cli() {
  if [ ! -f $HOME/.dashe/dashe_cli.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_cli.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_cli.sh

    chmod +x $HOME/.dashe/dashe_cli.sh
  fi
}

import_colors() {
  if [ ! -f $HOME/.dashe/dashe_colors.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_colors.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_colors.sh
  fi

  source $HOME/.dashe/dashe_colors.sh
}

import_dialogs() {
  if [ ! -f $HOME/.dashe/dashe_dialogs.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_dialogs.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_dialogs.sh
  fi

  source $HOME/.dashe/dashe_dialogs.sh
}

import_prompt() {
  if [ ! -f $HOME/.dashe/dashe_prompt.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_prompt.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_prompt.sh
  fi

  source $HOME/.dashe/dashe_prompt.sh
}

import_utils() {
  if [ ! -f $HOME/.dashe/dashe_utils.sh ]; then
    curl -k -s -o $HOME/.dashe/dashe_utils.sh https://d7uyonffhkqkw.cloudfront.net/dashe/src/dashe_utils.sh
  fi

  source $HOME/.dashe/dashe_utils.sh
}

