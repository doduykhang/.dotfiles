local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "Nop", opts)

keymap("n", "<leader>rr", ":so $MYVIMRC<CR>", opts)

--resize window 
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--split window 
keymap("n", "<leader>sh", "<C-w>s", opts)
keymap("n", "<leader>sx", "<C-w>v", opts)

--window navigation
keymap("n", "<C-LEFT>", ":vertical resize +5<CR>", opts)
keymap("n", "<C-RIGHT>", ":vertical resize -5<CR>", opts)
keymap("n", "<C-UP>", ":horizontal resize -5<CR>", opts)
keymap("n", "<C-DOWN>", ":horizontal resize +5<CR>", opts)

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

-- debugger
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>dc", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<leader>do", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<leader>di", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<leader>dO", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
--nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
--nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
--nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

keymap("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", {})
keymap("n", "<leader>tn", "<cmd>lua require('neotest').run.attach()<cr>", {})
keymap("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", {})
keymap("n", "<leader>ts", "<cmd>lua require('neotest').summary.open()<cr>", {})
keymap("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", {})
