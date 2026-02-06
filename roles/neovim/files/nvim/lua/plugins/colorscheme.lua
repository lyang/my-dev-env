return {
  "nordtheme/vim",
  name = "nord",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("nord")
  end,
}
