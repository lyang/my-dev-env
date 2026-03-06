return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "olimorris/neotest-rspec",
    "rcasia/neotest-java",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
        require("neotest-rspec"),
        require("neotest-java"),
        require("neotest-rust"),
        require("neotest-jest"),
      },
    })
  end,
}
