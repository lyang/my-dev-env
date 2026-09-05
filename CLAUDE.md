# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

An Ansible playbook that provisions a personal dev environment across macOS
(Apple Silicon and Intel), Ubuntu, Debian, and Fedora. `roles/` holds one role
per tool/app; `playbook.yaml` is auto-generated (gitignored) from that
directory by `setup.sh`, so **adding a role directory is sufficient** — no
separate registration file to edit.

## Commands

```bash
./setup.sh                        # full setup: OS bootstrap, Homebrew, Ansible, run playbook
./setup.sh --tags "neovim,tmux"   # run specific roles only (tag == role name)
```

Lint (matches CI):

```bash
ansible-lint roles/
npx --yes --package renovate -- renovate-config-validator   # validates renovate.json
```

Test a role end-to-end in a throwaway container:

```bash
./containerize.sh ubuntu:24.04
./containerize.sh debian:bookworm
./containerize.sh fedora:41
./containerize.sh --runtime docker ubuntu:24.04   # use Docker instead of Podman
```

Find which roles a change affects (used by CI, useful before pushing):

```bash
./scripts/find-affected-roles.sh origin/main
```

## Role structure and conventions

```
roles/<role>/
  tasks/main.yaml       # entry point
  defaults/main.yaml    # default variables (versions, config) — optional
  meta/main.yaml        # role dependencies — optional
  files/                # config files, often symlinked into ~
```

- **Single-platform, single-package roles** (most Homebrew-only installs, e.g.
  `chatgpt`) are just a `tasks/main.yaml` with a `community.general.homebrew`
  or `homebrew_cask` task, gated with
  `when: ansible_facts['os_family']|lower == "darwin"`.
- **Cross-platform roles** (e.g. `onepassword`, `google-chrome`) instead have
  `tasks/main.yaml` dispatch by OS family:
  ```yaml
  - name: "Setup For {{ ansible_facts['system'] }}"
    ansible.builtin.include_tasks: "{{ ansible_facts['os_family'] | lower }}.yaml"
  ```
  with sibling `darwin.yaml` (Homebrew cask), `debian.yaml` (apt, covers
  Debian and Ubuntu since both report `os_family: Debian`), and `redhat.yaml`
  (dnf, covers Fedora) files. Follow this pattern — not a bespoke `when:` per
  task — when a role needs to install something differently per OS.
- Shell tasks must set `executable: /bin/bash`.
- `creates:` on a shell task must live under that task's `args:`, not at the
  top level (top-level `creates:` causes a "conflicting action statements"
  error).
- Use `force: true` on `ansible.builtin.file` symlink tasks so they idempotently
  replace an existing dir/file.
- Role dependencies go in `meta/main.yaml`; `shell-env` is the common
  dependency for anything that needs to export environment variables, since
  it creates `~/.generated/shared-env.sh`, sourced by both bash and zsh.
- Role directory names intentionally mirror upstream package/tool names
  (`gh-cli`, `go-task`, `libglib2.0-bin`) even though this violates
  ansible-lint's `role-name` rule; that rule is disabled in `.ansible-lint`
  rather than renaming roles, since renaming would ripple through tags, the
  playbook, CI matrices, and docs for no functional benefit.

## CI

- `.github/workflows/{macos,ubuntu,debian,fedora}.yml` each call the reusable
  `roles.yml` workflow for their platform.
- `roles.yml`: lints with `ansible-lint` and validates `renovate.json`, then
  computes affected roles via `scripts/find-affected-roles.sh` (changed roles
  in the diff, plus anything that lists a changed role as a dependency in its
  `meta/main.yaml`), then applies only those roles in a matrix using
  `./setup.sh --tags <role>`.
- [Renovate](https://docs.renovatebot.com/) keeps language versions, cargo
  crate versions, and git commit pins current via custom regex managers in
  `renovate.json`.

## Neovim config

Lives in `roles/neovim/files/nvim/` (Lua + lazy.nvim), symlinked to
`~/.config/nvim`. See the README for the full keymap reference.

- Load order in `init.lua`: options → lazy → keymaps → autocmds.
- Plugin specs are auto-discovered from `lua/plugins/*.lua`.
- `vim.filetype.add()` must stay in `options.lua` (loads before plugins) or
  conform.nvim emits spurious warnings.
- lazy.nvim's lockfile is gitignored via `roles/neovim/files/nvim/.gitignore`.
- Targets Neovim 0.11+ APIs: `require('nvim-treesitter').install({...})`
  (not the removed `nvim-treesitter.configs`, and must be `lazy = false`);
  `vim.lsp.config()` + `vim.lsp.enable()` (not `lspconfig[server].setup()`),
  with keymaps attached via an `LspAttach` autocmd; mason-lspconfig v2 with
  `automatic_enable = true` (plugin org is `mason-org/`).
- conform.nvim's checkhealth warning about unknown compound filetypes (e.g.
  `yaml.docker-compose`) is expected and can't be suppressed.

## Git workflow

- Do not add Co-Authored-By lines, and do not mention Claude, in commits or
  PRs.
- PR descriptions: summary only, no test plan section.
- To squash a fixup into an older commit non-interactively:
  `git commit --fixup=<sha>` then
  `GIT_SEQUENCE_EDITOR=true git rebase --autosquash -i <base>`.
