# my-dev-env

[![Debian](https://github.com/lyang/my-dev-env/actions/workflows/debian.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/debian.yml)
[![Ubuntu](https://github.com/lyang/my-dev-env/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/ubuntu.yml)
[![Fedora](https://github.com/lyang/my-dev-env/actions/workflows/fedora.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/fedora.yml)
[![macOS](https://github.com/lyang/my-dev-env/actions/workflows/macos.yml/badge.svg)](https://github.com/lyang/my-dev-env/actions/workflows/macos.yml)

Ansible playbook that automates the setup of my development environment across macOS and Linux.

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

## Roles

| Category | Roles |
|----------|-------|
| **Shell & Terminal** | ohmyzsh, tmux, colorscheme, nerdfonts, shell-env |
| **Editors** | neovim, intellij |
| **Languages** | sdkman (Java/Maven/Gradle), pyenv, rbenv, rustup, node, poetry |
| **Containers** | docker, podman |
| **Kubernetes** | helm, flux, talosctl, kustomize, kubeconform |
| **Cloud & Infra** | awscli, tfenv, terraform-ls, sops, age |
| **Dev Tools** | gitconfig, gnupg, gh-cli, jq, yq, bazelisk, go-task |
| **CLI Tools** | bat, fd-find, git-delta, minijinja-cli (via rustup/cargo) |
| **Apps** | 1password, claude-code, chatgpt, peon-ping |

## Architecture

```
roles/
  <role>/
    tasks/main.yaml       # Role tasks (platform-specific includes)
    defaults/main.yaml    # Default variables (versions, config)
    meta/main.yaml        # Role dependencies
    files/                # Config files (symlinked to ~)
```

`setup.sh` auto-generates `playbook.yaml` from the `roles/` directory, installs
Homebrew and Ansible if needed, then runs the playbook. Roles share environment
through `shell-env`, which creates `~/.generated/shared-env.sh` sourced by both
bash and zsh.

[Renovate](https://docs.renovatebot.com/) keeps language versions, cargo crate
versions, and git commit pins up to date via custom regex managers in
`renovate.json`.

## Testing

Build and test in a container:

```bash
./containerize.sh ubuntu:24.04
./containerize.sh debian:bookworm
./containerize.sh fedora:41
```

Use `--runtime docker` to use Docker instead of Podman:

```bash
./containerize.sh --runtime docker ubuntu:24.04
```

CI runs per-platform workflows that lint with `ansible-lint` and apply only
affected roles (detected via git diff and role dependency graph).

---

## Neovim

Config lives in `roles/neovim/files/nvim/` and is symlinked to `~/.config/nvim`.
Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
Leader key is `Space`.

### Windows

| Key | Action |
|-----|--------|
| `Ctrl-h/j/k/l` | Navigate windows |
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical |
| `<leader>wc` | Close window |
| `<leader>wo` | Close other windows |

### Find (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` or `<leader><leader>` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>fb` | Buffers |
| `<leader>fo` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fd` | Diagnostics |
| `<leader>fs` | Document symbols |
| `<leader>fr` | Resume last picker |
| `<leader>ft` | Find TODOs |

### File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree |
| `<leader>E` | Find current file in nvim-tree |
| `-` | Open parent directory (Oil) |

### Buffer

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete current buffer |
| `<leader>bo` | Delete other buffers |
| `<leader>.` | Toggle scratch buffer |
| `<leader>us` | Select scratch buffer |

### Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (fugitive) |
| `<leader>gg` | Lazygit |
| `<leader>go` | Open in browser |
| `<leader>gl` | Git log |
| `<leader>gS` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gB` | Blame buffer |
| `<leader>gd` | Diff |
| `]c` / `[c` | Next / previous hunk |

### LSP

| Key | Action |
|-----|--------|
| `grd` | Go to definition |
| `grt` | Go to type definition |
| `grD` | Go to declaration |
| `<leader>cf` | Format buffer |
| `<leader>li` | LSP health info |
| `<leader>lr` | Restart LSP |
| `<leader>lw` | Workspace folders |

Installed LSP servers: bashls, buf_ls, docker_compose_language_service,
dockerls, graphql, jdtls, jsonls, lemminx, lua_ls, marksman, pyright,
ruby_lsp, rust_analyzer, terraformls, ts_ls, vimls, yamlls.

### Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle all diagnostics |
| `<leader>xd` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xf` | Diagnostic float |
| `<leader>xt` | TODOs |
| `]T` / `[T` | Next / previous TODO |

### Code

| Key | Action |
|-----|--------|
| `<leader>ca` | Swap next argument |
| `<leader>cA` | Swap previous argument |
| `<leader>cR` | Rename file |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last session |
| `<leader>dx` | Terminate |
| `<leader>du` | Toggle DAP UI |

Adapters: python, codelldb (C++/Rust), js.

### Test (Neotest)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle summary |
| `<leader>to` | Show output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop tests |
| `<leader>td` | Debug nearest test |

Adapters: Python, RSpec, Java, Rust, Jest.

### Motion & Editing

| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash Treesitter jump |
| `gza` / `gzd` / `gzr` | Add / delete / replace surround |
| `]m` / `[m` | Next / previous function |
| `]]` / `[[` | Next / previous class |
| `af` / `if` | Outer / inner function (text object) |
| `ac` / `ic` | Outer / inner class (text object) |
| `aa` / `ia` | Outer / inner argument (text object) |

### Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `Ctrl-Space` | Trigger completion |
| `Tab` / `Shift-Tab` | Next / previous item |
| `Enter` | Confirm selection |
| `Ctrl-e` | Abort |
| `Ctrl-b` / `Ctrl-f` | Scroll docs |

### Other

| Key | Action |
|-----|--------|
| `Esc` | Clear search highlight |
| `Ctrl-/` | Toggle terminal |
| `<leader>un` | Notification history |
| `<leader>ud` | Dismiss notifications |
| `<leader>?` | Show buffer keymaps (which-key) |

### Formatting on Save (conform.nvim)

| Language | Formatter |
|----------|-----------|
| Go | goimports |
| GraphQL, JS/TS, JSON, Markdown, YAML | prettier |
| Java | google-java-format |
| Lua | stylua |
| Proto | buf |
| Python | ruff_format |
| Ruby | rubocop |
| Rust | rustfmt |
| Shell | shfmt |
| Terraform | terraform_fmt |
| XML | xmlformat |

---

## Tmux

Config lives in `roles/tmux/files/tmux.conf`. Prefix is `Ctrl-a`.

### Custom Bindings

| Key | Action |
|-----|--------|
| `prefix N` | New named window in current path |

### Pane Navigation (tmux-pain-control)

| Key | Action |
|-----|--------|
| `prefix h/j/k/l` | Move between panes |
| `prefix H/J/K/L` | Resize panes |
| `prefix \|` | Split vertical |
| `prefix -` | Split horizontal |

### Session Persistence (tmux-resurrect + tmux-continuum)

| Key | Action |
|-----|--------|
| `prefix Ctrl-s` | Save session |
| `prefix Ctrl-r` | Restore session |

### Settings

| Setting | Value |
|---------|-------|
| Mode keys | vi |
| Base index | 1 |
| Auto rename | `#{b:pane_current_path}` |
| Renumber windows | on |
| Color support | `terminal-features` RGB |
| Theme | Nord |

### Plugins

- [nord-tmux](https://github.com/arcticicestudio/nord-tmux) — Color scheme
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) — Continuous session saving
- [tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control) — Pane navigation and resizing
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) — Save and restore sessions
- [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) — Sensible defaults
- [tpm](https://github.com/tmux-plugins/tpm) — Plugin manager

## License

[MIT](LICENSE)
