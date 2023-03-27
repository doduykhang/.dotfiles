vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function (use)
	use 'folke/tokyonight.nvim'
	use {
    		"williamboman/mason.nvim",
    		"williamboman/mason-lspconfig.nvim",
    		"neovim/nvim-lspconfig",
	}
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
  -- Packer
   use{
        "folke/noice.nvim",
        }
use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
}
use {
  "vigoux/notifier.nvim",
  config = function()
    require'notifier'.setup {
    }
  end
}
use {
  "someone-stole-my-name/yaml-companion.nvim",
  requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("telescope").load_extension("yaml_schema")
  end,
}
end)
