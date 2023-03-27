-- examples for your init.lua

print("nvim_tree")
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- OR setup with some options
require("nvim-tree").setup()

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle <CR>")

