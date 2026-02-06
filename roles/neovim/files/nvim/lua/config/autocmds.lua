vim.cmd([[highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=darkred guifg=white]])

local augroup = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*bundler/config",
  callback = function() vim.bo.filetype = "yaml" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "cookiecutterrc",
  callback = function() vim.bo.filetype = "yaml" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "gitconfig",
  callback = function() vim.bo.filetype = "gitconfig" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "Dockerfile*",
  callback = function() vim.bo.filetype = "dockerfile" end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup,
  callback = function()
    if vim.bo.filetype ~= "help" then
      vim.fn.matchadd("ExtraWhitespace", [[\t\+\|\s\+$]])
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = augroup,
  callback = function() vim.fn.clearmatches() end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup,
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup,
  callback = function()
    if vim.bo.filetype ~= "help" then
      vim.fn.matchadd("ExtraWhitespace", [[\t\+\|\s\+\%#\@<!$]])
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function()
    if vim.bo.filetype ~= "help" then
      vim.fn.matchadd("ExtraWhitespace", [[\t\+\|\s\+$]])
    end
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "[^l]*",
  nested = true,
  command = "cwindow",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "l*",
  nested = true,
  command = "lwindow",
})
