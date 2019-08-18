# Dev Container Examples

## Description

An archive of remote development containers.

If you would like to build your own, see [here](https://github.com/microsoft/vscode-dev-containers) for a list of other dev container examples.

## Configuring Development Containers

Configure `DockerFile`, `.zshrc`, and `devcontainer.json` located in `.devcontainer`. First, set your username in the Dockerfile,

```docker
ARG USER_NAME="your username"
```

Next, you will have to modify the COPY command near the bottom, until it's allowed to be dynamically populated via ENV or ARG.

```docker
COPY --chown=username:username ...
```

In `devcontainer.json`, add any extensions and settings you wish to use for development. Note that I have a lot more extensions in my containers than I do in my local environment. One of the primary motives for establishing a remote development environment is to keep your local computer clean. You will also need to add your environmental variables here.

```jsonc
// devcontainer.json
{
    "name": "My Dev Env",
    "dockerFile": "Dockerfile",
    "runArgs": [
        // add your environmental variables here
        "-e", "GITHUB_TOKEN=<access_token>",
        "-e", "GITHUB_USER=<ntid>",
        "-v", "dev-env-volume:/root/.vscode-server",
        "-v", "/var/run/docker.sock:/var/run/docker.sock"
    ],
    "extensions": [
        "ms-python.python",
        "eamodio.gitlens",
        "ms-azuretools.vscode-docker",
        // add your extentions here
  ],
    "settings": {
        "remote.extensionKind": {
            "ms-azuretools.vscode-docker": "workspace"
        }
    }
}
```

## Troubleshooting

- [Remote Containers Docs](https://code.visualstudio.com/docs/remote/containers)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Email Me](mailto:austin_hardt@comcast.com)

## TODO

- [x] ~add github credentials~
- [x] ~customize zsh, styles and functions~
- [x] ~figure out homebrew~
- [x] ~kubectl and docker containers inside of a container?~
- [x] ~figure out oc and helm installation~
- [ ] figure out solution to COPY && chown issues
- [x] ~automate adding of aws credentials~
- [ ] automate refresh of aws credentials
- [ ] make more templates
