local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window management
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<cr>", { desc = "Delete other buffers" })
