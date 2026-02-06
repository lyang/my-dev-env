return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "bashls",
        "buf_ls",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "graphql",
        "jdtls",
        "jsonls",
        "lemminx",
        "lua_ls",
        "marksman",
        "pyright",
        "ruby_lsp",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "vimls",
        "yamlls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "actionlint",
          "google-java-format",
          "prettier",
          "ruff",
          "shfmt",
          "stylua",
          "xmlformatter",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure all servers with shared capabilities and keymaps
      local servers = {
        "bashls",
        "buf_ls",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "graphql",
        "jdtls",
        "jsonls",
        "lemminx",
        "marksman",
        "pyright",
        "ruby_lsp",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "vimls",
        "yamlls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, noremap = true, silent = true })
          end

          map("n", "gd", vim.lsp.buf.definition)
          map("n", "gD", vim.lsp.buf.declaration)
          map("n", "gi", vim.lsp.buf.implementation)
          map("n", "gr", vim.lsp.buf.references)
          map("n", "K", vim.lsp.buf.hover)
          map("n", "<C-k>", vim.lsp.buf.signature_help)
          map("n", "<space>D", vim.lsp.buf.type_definition)
          map("n", "<space>ca", vim.lsp.buf.code_action)
          map("n", "<space>e", vim.diagnostic.open_float)
          map("n", "<space>q", vim.diagnostic.setloclist)
          map("n", "<space>rn", vim.lsp.buf.rename)
          map("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end)
          map("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
          map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
          map("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end)
          map("n", "[d", vim.diagnostic.goto_prev)
          map("n", "]d", vim.diagnostic.goto_next)
        end,
      })
    end,
  },
}
