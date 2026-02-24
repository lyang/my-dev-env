-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Filetypes
vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    jsx = "javascript.jsx",
    tsx = "typescript.tsx",
    xsl = "xsl",
    xslt = "xsl",
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
  pattern = {
    ["%.github/workflows/.*%.ya?ml"] = "yaml.github",
    ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
    ["helmfile.*%.ya?ml"] = "yaml.helm-values",
    ["values.*%.ya?ml"] = "yaml.helm-values",
    [".*%.tfvars"] = "terraform-vars",
  },
})

-- Providers
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/neovim/bin/python"

-- Encoding & formats
vim.opt.encoding = "utf-8"
vim.opt.fileformats = { "unix", "mac", "dos" }

-- Editing
vim.opt.autoread = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.linespace = 0
vim.opt.list = true
vim.opt.listchars = { tab = "◆◆" }
vim.opt.mouse = ""
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.updatetime = 200

-- UI
vim.opt.background = "dark"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.ruler = true
vim.opt.scrolloff = 10
vim.opt.showcmd = true
vim.opt.showmatch = true
