local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
map("n", "<leader>fa", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>ft", "<cmd>Telescope tags<cr>", opts)

-- NvimTree
map("n", "<LocalLeader>nt", "<cmd>NvimTreeToggle<cr>", opts)
map("n", "<LocalLeader>nf", "<cmd>NvimTreeFindFile<cr>", opts)
map("n", "<LocalLeader>nr", "<cmd>NvimTreeRefresh<cr>", opts)

-- Fugitive
map("n", "<LocalLeader>gw", ":Ggrep! <cword><cr><cr>", opts)
