-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function(use)
  -- Packer manager
  use 'wbthomason/packer.nvim'

  -- Utilities
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'ur4ltz/surround.nvim',
    config = function()
      require'surround'.setup { mappings_style = 'surround' }
    end
  }
  use 'tpope/vim-commentary'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'andweeb/presence.nvim'
  use 'tpope/vim-fugitive'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'mhartington/formatter.nvim'

  -- Competitive programming
  use { 'searleser97/cpbooster.vim', ft = {'cpp'} }

  -- Integration
  use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Debugging
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"}
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'github/copilot.vim'

  -- Language support LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    }
  }

  -- Syntax Highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'norcalli/nvim-colorizer.lua'

  -- Interface
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'kdheepak/tabline.nvim',
    requires = {
      { 'hoob3rt/lualine.nvim', opt=true },
      {'kyazdani42/nvim-web-devicons', opt = true}
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  use {
      'nvim-tree/nvim-tree.lua',
      requires = 'nvim-tree/nvim-web-devicons',
  }

  -- Colorscheme
  use 'sainnhe/gruvbox-material'

end)
