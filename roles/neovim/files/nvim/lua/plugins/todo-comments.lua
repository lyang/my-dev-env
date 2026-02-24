return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "]T", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
    { "[T", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs (Trouble)" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
  },
  opts = {},
}
