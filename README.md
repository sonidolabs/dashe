<div align="center">
  <a href="#installation">Installation</a> 
  &nbsp;&nbsp;
  <a href="#features">Features</a> 
  &nbsp;&nbsp;
  <a href="#commands">Commands</a>
  &nbsp;&nbsp;
  <a href="#support-and-contribution">Contributions</a>
</div>

<br>

![Dashe banner](/src/imgs/dashe_cover_en.png)


Tradução: [Português Brasileiro](./README.pt-BR.md)

### Prerequisites

`Bash` - Version 5.0.17 or newer <br>
`GIT` - Version 2.25.1 or newer <br>
`cURL` - Version 7.68.0 or newer

---

### Installation

Copy, paste, and execute one of the three installation methods in your terminal:

#### cURL
```bash
bash <(curl -k -s https://d7uyonffhkqkw.cloudfront.net/dashe/install.sh)
```

#### GIT
If you prefer, change '~' to your preferred folder
```bash
cd ~ && git clone https://github.com/sonidolabs/dashe.git && chmod +x ~/dashe/install.sh && ~/dashe/install.sh
```
---

### Features

Dashe has a variety of commands to customize the colors of the username, prompt symbol, folder path, and separators. It is also possible to set a different username than the default and use symbols and emojis to give your prompt a personal touch.

---

### Commands

| Command                                               | Description                            |
| -----------                                           | -----------                            |
| `--version`                                           | Display current version.               |
| `--update`                                            | Update all scripts and files.          |
| `--uninstall`                                         | Uninstall Dashe.                       |
| `--replace-alias-name <old name> <new name>`          | Replaces an existing alias name.       |
| `--replace-alias-value <old value> <new value>`       | Replaces an existing alias value.      |
| `--set-username <username>`                           | Set the username in the prompt.        |
| `--set-alias <alias> <command>`                       | Set a new alias.                       |
| `--set-separator <separator>`                         | Set a separator in the prompt.         |
| `--set-symbol <symbol>`                               | Set the symbol character.              |
| `--set-username-color <color>`                        | Set the username color.                |
| `--set-separator-color <color>`                       | Set the separator color.               |
| `--set-path-color <color>`                            | Set the path color.                    |
| `--set-symbol-color <color>`                          | Set the symbol character color.        |
| `--all-colors`                                        | Display all available colors.          |
| `--help`                                              | Show all help and commands.            |

#### Usage Examples

```bash
# Setting a username
$ dashe --set-username "👑 Ragnar Lothbrok"

# Resetting the username
$ dashe --set-username "\\\\u"

# Setting the username color
$ dashe --set-username-color 197

# Setting a separator (Example: 👑 Ragnar Lothbrok "•" ~/projects "•" (Master ●) ツ)
$ dashe --set-separator " • "

# Setting a symbol (Example: 👑 Ragnar Lothbrok • ~/projects • (Master ●) "ツ")
$ dashe --set-symbol "ツ"
```

> **Notes** <br><br>
> \- Always use quotes when entering strings as input.<br>
> \- Use four backslashes when entering escape sequences in the input.<br>
> \- Some icons and symbols may not render correctly in the prompt.<br><br>

<br>

Recommended sites for using symbols and emojis:

**Symbols**: https://coolsymbol.com/ <br>
**Emojis**: https://emojipedia.org/

---

### GIT Integration

Within a directory with an active GIT repository, you can track the state of changes in real-time:

<br>

| Status      | Descrição |
| ----------- | ----------- |
| 🔴 | There are files with changes not staged for commit |
| 🟡 | Files have been staged |
| 🟢 | Changes are ready to be pushed to the remote repository |
| ⚪ | There are no pending changes for commit, the repository is clean |

<br>

`Don't mistake again:` Master, Main, and Develop branches will be highlighted in red, while others will be colored in yellow!

<br>

> Branch colors cannot be changed!

---

### Support and Contribution

If you encounter any issues or have suggestions for improvements, feel free to open an [issue](https://github.com/sonidolabs/dashe/issues) on the GitHub repository.

If you want to contribute, please open a [pull request](https://github.com/sonidolabs/dashe/pulls) in the repository.

---

### Next steps

- Migrate the codebase to AWS.
- Create login system and save user configs.

---

### License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---
