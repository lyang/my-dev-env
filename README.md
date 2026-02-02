# my-dev-env

[![Debian](https://github.com/lyang/my-dev-env/actions/workflows/debian.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/debian.yml)
[![Ubuntu](https://github.com/lyang/my-dev-env/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/ubuntu.yml)
[![Fedora](https://github.com/lyang/my-dev-env/actions/workflows/fedora.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/fedora.yml)
[![macOS](https://github.com/lyang/my-dev-env/actions/workflows/macos.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/macos.yml)

Ansible playbook that automates the setup of my development environment.

## Supported Platforms

- macOS (Apple Silicon and Intel)
- Ubuntu
- Debian
- Fedora

## Usage

```bash
./setup.sh
```

To run specific roles:
```bash
./setup.sh --tags "neovim,tmux"
```

## Included Roles

| Category | Roles |
|----------|-------|
| **Shell** | ohmyzsh, tmux, colorscheme, nerdfonts |
| **Editors** | neovim, intellij |
| **Languages** | sdkman (Java/Maven/Gradle), pyenv, rbenv, rustup, node, poetry |
| **Containers** | docker, podman |
| **Kubernetes** | helm, flux, talosctl, kustomize, kubeconform |
| **Cloud/Infra** | awscli, tfenv, terraform-ls, sops, age |
| **Tools** | git, gnupg, gh-cli, jq, yq, bazelisk, go-task |
| **Apps** | 1password, claude-code, chatgpt |

## Testing

Build and test in a container:
```bash
./containerize.sh <distro>:<tag>
```

Examples:
```bash
./containerize.sh ubuntu:24.04
./containerize.sh debian:bookworm
./containerize.sh fedora:41
```

Use `--runtime docker` to use Docker instead of Podman:
```bash
./containerize.sh --runtime docker ubuntu:24.04
```
