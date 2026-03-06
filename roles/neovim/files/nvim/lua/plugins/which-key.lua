return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    icons = {
      mappings = false,
    },
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>t", group = "Test" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Diagnostics" },
      { "gr", group = "LSP (go to)" },
      { "gz", group = "Surround" },
      { "]", group = "Next" },
      { "[", group = "Prev" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
