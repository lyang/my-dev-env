return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "goimports" },
        graphql = { "prettier" },
        java = { "google-java-format" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        proto = { "buf" },
        python = { "ruff_format" },
        ruby = { "rubocop" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        typescript = { "prettier" },
        xml = { "xmlformat" },
        yaml = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    })
  end,
}
