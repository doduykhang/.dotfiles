local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function (use)
    use 'folke/tokyonight.nvim'
    use 'catppuccin/nvim'
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    -- nvim v0.7.2
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets'
    }
    use {
        'nvim-tree/nvim-tree.lua',
        'nvim-tree/nvim-web-devicons'
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        'vim-airline/vim-airline',
        'vim-airline/vim-airline-themes'
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'edluffy/hologram.nvim'}
    use { 'christoomey/vim-tmux-navigator' }
    use 'ray-x/go.nvim'

    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'jay-babu/mason-nvim-dap.nvim'
    use "mxsdev/nvim-dap-vscode-js"
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        }
    }
    use 'haydenmeade/neotest-jest'

end)
