return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
  },
  opts = {},
}
