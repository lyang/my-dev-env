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
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
          end

          -- Extend Neovim 0.11 gr* convention
          map("n", "grd", vim.lsp.buf.definition, "Go to definition")
          map("n", "grt", vim.lsp.buf.type_definition, "Go to type definition")
          map("n", "grD", vim.lsp.buf.declaration, "Go to declaration")

          -- Code actions
          map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")

          -- LSP management
          map("n", "<leader>li", "<cmd>checkhealth lsp<cr>", "LSP info")
          map("n", "<leader>lr", "<cmd>LspRestart<cr>", "Restart LSP")
          map("n", "<leader>lw", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "Workspace folders")

          -- Diagnostics (merged into <leader>x group)
          map("n", "<leader>xf", vim.diagnostic.open_float, "Diagnostic float")
          map("n", "<leader>xq", vim.diagnostic.setloclist, "Send to location list")
        end,
      })
    end,
  },
}
