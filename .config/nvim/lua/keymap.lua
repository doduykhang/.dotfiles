local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "Nop", opts)

--window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>ft', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- vim.api.nvim_set_keymap("n", "<c-c>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})

--copy to clipboard
keymap("v", "<C-y>", '"+y', opts)
keymap("n", "<C-y>", '"+y', opts)

keymap("v", "<C-p>", '"+p', opts)
keymap("n", "<C-p>", '"+p', opts)
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)

