return {
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      -- Remap to gz* to avoid conflict with flash.nvim's s key
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
      },
    },
  },
  { "RRethy/nvim-treesitter-endwise", event = "InsertEnter" },
  { "tpope/vim-rails", ft = "ruby" },
  { "tpope/vim-rake", ft = "ruby" },
  { "tpope/vim-projectionist" },
}
