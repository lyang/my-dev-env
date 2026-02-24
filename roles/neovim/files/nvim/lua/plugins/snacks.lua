return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Terminal
    { "<C-/>", function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },

    -- Lazygit
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

    -- Git browse
    { "<leader>go", function() Snacks.gitbrowse() end, desc = "Open in browser", mode = { "n", "v" } },

    -- Scratch
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
    { "<leader>us", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },

    -- Utilities
    { "<leader>un", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "<leader>ud", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },

    -- Buffer delete (replaces :bdelete, preserves window layout)
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },

    -- Rename
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
  },
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    notifier = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
    terminal = { enabled = true },
    lazygit = { enabled = true },
    gitbrowse = { enabled = true },
    git = { enabled = true },
    scratch = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "g", desc = "Grep", action = ":Telescope live_grep" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
