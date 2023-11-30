<div align="center">
  <a href="#instalação">Instalação</a> 
  &nbsp;&nbsp;
  <a href="#features">Features</a> 
  &nbsp;&nbsp;
  <a href="#comandos">Comandos</a>
  &nbsp;&nbsp;
  <a href="#suporte-e-contribuição">Contribuições</a>
</div>

## Dashe - Tornando fácil a customização do seu prompt

Translation: [English](./README.md)

Dashe é um script CLI que torna fácil personalizar o seu prompt de acordo com o seu estilo!

### Pré Requisitos

`Bash` - Versão 5.0.17 ou mais recente <br>
`GIT` - Versão 2.25.1 ou mais recente <br>
`curl` - Versão 7.68.0 ou mais recente <br>
`Wget` - Versão 1.20.3 ou mais recente

---

### Instalação

Copie, cole e execute em seu terminal uma das três maneiras de instalação:

#### curl
```bash
bash <(curl -k -s https://raw.githubusercontent.com/Gabriel3atista/dashe/master/install.sh)
```

#### Wget
```bash
bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/Gabriel3atista/dashe/master/install.sh)
```

#### GIT
Caso queira, mude o '`~`' para sua pasta de preferência

```bash
cd ~ && git clone https://github.com/Gabriel3atista/dashe.git && chmod +x ~/dashe/install.sh && ~/dashe/install.sh
```
---

### Features

O Dashe tem uma série de comandos para personalizar as cores do nome de usuário, simbolo do prompt, caminho de pastas e os separadores. Também é possível definir um nome de usuário diferente do padrão e utilizar símbolos e emojis para deixar seu prompt com a sua personalidade.

---

### Comandos

| Status                   | Descrição                                  |
| -----------              | -----------                                |
| `--version`              | Exibir versão atual.                       |
| `--update`               | Atualizar todos os scripts e arquivos.     |
| `--uninstall`            | Desinstalar o Dashe.                       |
| `--set-username`         | Define o nome de usuário no prompt.        |
| `--set-separator`        | Define o separador no prompt.              |
| `--set-symbol`           | Define o caractere de símbolo.             |
| `--set-username-color`   | Define a cor do nome de usuário.           |
| `--set-separator-color`  | Define a cor do separador.                 |
| `--set-path-color`       | Define a cor do caminho.                   |
| `--set-symbol-color`     | Define a cor do caractere de símbolo.      |
| `--all-colors`           | Exibe todas as cores disponíveis.          |
| `--help`                 | Mostra todas as ajudas e comandos.         |

#### Exemplos de uso

```bash
# Definindo um nome de usuário
$ dashe --set-username "👑 Ragnar Lothbrok"

# Resetando o nome de usuário
$ dashe --set-username "\\\\u"

# Definindo a cor do nome de usuário
$ dashe --set-username-color 197

# Definindo um separador (Exemplo: 👑 Ragnar Lothbrok "•" ~/projects "•" (Master ●) ツ)
$ dashe --set-separator " • "

# Definindo um simbolo (Exemplo: 👑 Ragnar Lothbrok • ~/projects • (Master ●) "ツ")
$ dashe --set-symbol "ツ"
```

> **Notas** <br><br>
> \- Sempre utilize aspas ao inserir strings como entrada.<br>
> \- Utilize quatro barras invertidas ao inserir sequências de escape no input.<br>
> \- Alguns ícones e símbolos podem não renderizar corretamente no prompt.<br><br>

<br>

Sites recomendados para utilizar símbolos e emojis:

**Símbolos**: https://coolsymbol.com/ <br>
**Emojis**: https://emojipedia.org/

---

### Integração com o GIT

Dentro de um diretório com um repositório GIT ativo, você pode acompanhar o estado das alterações em tempo real:

<br>

| Status      | Descrição |
| ----------- | ----------- |
| 🔴 | Existem arquivos com alterações que não foram registradas em um commit |
| 🟡 | Arquivos foram para Stage |
| 🟢 | Alterações prontas para serem enviadas para o repositório remoto |
| ⚪ | Não há alterações pendentes para commit, o repositório está limpo |

<br>

`Para evitar equívocos:` As branches Master, Main e Develop estarão destacadas em vermelho, enquanto as demais estarão coloridas em amarelo!

<br>

> Não é possível alterar as cores das branches!

---

### Suporte e Contribuição

Se você encontrar algum problema ou tiver sugestões para melhorias, sinta-se à vontade para abrir uma [issue](https://github.com/Gabriel3atista/dashe/issues) no repositório do GitHub.

Se você deseja contribuir, por favor abra uma [pull request](https://github.com/Gabriel3atista/dashe/pulls) no repositório.

---

### Licença

Este projeto está licenciada sob a [Licença MIT](https://opensource.org/licenses/MIT).

---
