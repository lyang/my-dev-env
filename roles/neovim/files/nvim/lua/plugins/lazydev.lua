return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = {
      { "folke/lazydev.nvim" },
    },
  },
}
