return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep current word" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>gl", "<cmd>Telescope git_commits<cr>", desc = "Git log" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
