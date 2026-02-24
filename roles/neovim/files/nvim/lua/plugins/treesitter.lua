return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "graphql",
        "hcl",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "proto",
        "python",
        "ruby",
        "rust",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Text object selection
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "outer function" })
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "outer class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "inner class" })
      vim.keymap.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, { desc = "outer argument" })
      vim.keymap.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, { desc = "inner argument" })

      -- Movement
      vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
      vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class" })

      -- Swap
      vim.keymap.set("n", "<leader>ca", function() swap.swap_next("@parameter.inner") end, { desc = "Swap with next argument" })
      vim.keymap.set("n", "<leader>cA", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap with prev argument" })
    end,
  },
}
