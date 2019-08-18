# Remote Development Containers

## Description

remote development containers

## Prerequisites

### 1. Install Docker for Windows

Download and install [docker](https://hub.docker.com/editions/community/docker-ce-desktop-windows). If it asks you
if you want to _use windows containers_, don't do it, use linux. Also be sure to add your C drive to _Shared Drives_ in settings.

### 2. Install & Configure Visual Studio Code Insiders

Download and install [Visual Studio Code Insiders](https://code.visualstudio.com/insiders/) and add the following extensions.
Note that all styles are inherited from the local installation of VS Code, not from the container, so this is where you add any themes and styles.

```javascript
ms-vscode-remote.remote-containers
ms-azuretools.vscode-docker
// themes, etc.
```

In order for your zsh to render properly, you will need to install a patched nerd font, which you can find [here](https://www.nerdfonts.com/). I recommend `Hack NF`. Open `settings.json` (press `CTRL + SHIFT + P` and search for settings) and configure to your specifications, although be sure to keep your integrated shell (linux) set to `/usr/bin/zsh`.

```jsonc
// settings.json
{
    // theme and icons
    "workbench.iconTheme": "vscode-icons",
    "workbench.colorTheme": "Night Owl (No Italics)",

    // configure terminal settings
    "terminal.integrated.fontFamily": "Hack NF",
    "terminal.integrated.shell.linux": "/usr/bin/zsh",
    "terminal.integrated.cursorStyle": "line",
}
```

## Installation

To be continued...

## TODO

- [ ] build a docker-machine executable that allows the use of an ssh config (permitting autobahn's jump servers)
- [ ] create cli to automate spawning, connecting, and deletion of dev containers.
- [ ] write up installation, descriptions for container templates
- [ ] clean up contatiner templates
- [ ] cli to build devcontainer.json files
