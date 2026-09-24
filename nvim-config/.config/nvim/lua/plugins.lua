-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

-- packer is not in any package list, and ~/.local/share/nvim is not carried
-- between machines, so a fresh one has no packer at all and init.lua died on
-- its first require. Clone it on first launch; init.lua stops after this
-- file until the sync below has installed everything else.
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
  PACKER_BOOTSTRAP = true
end

return require('packer').startup(function(use)
  -- Packer manager
  use 'wbthomason/packer.nvim'

  -- Utilities
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'ur4ltz/surround.nvim',
    config = function()
      require 'surround'.setup { mappings_style = 'surround' }
    end
  }
  use 'tpope/vim-commentary'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  -- use 'andweeb/presence.nvim'
  use 'tpope/vim-fugitive'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'mhartington/formatter.nvim'

  -- Competitive programming
  use { 'searleser97/cpbooster.vim', ft = { 'cpp' } }

  -- Integration
  use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'coder/claudecode.nvim',
    requires = { 'folke/snacks.nvim' },
    config = function()
      require('claudecode').setup()

      -- General keymaps
      vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
      vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
      vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
      vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
      vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
      vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })

      -- Visual mode
      vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })

      -- Diff management
      vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
      vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

      -- File tree keymap (ft-specific, using autocmd)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
        callback = function(ev)
          vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>',
            { desc = 'Add file', buffer = ev.buf })
        end,
      })
    end,
  }


  -- Debugging
  -- use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use { "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  -- use 'github/copilot.vim'
  use {
    'Exafunction/codeium.vim',
    config = function()
      vim.g.codeium_no_map_tab = 1
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<C-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  }

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
  -- On the bootstrap launch the plugin is cloned but not yet on the
  -- runtimepath, so :TSUpdate does not exist; nv-treesitter's install() list
  -- builds the parsers on the next launch instead.
  use { 'nvim-treesitter/nvim-treesitter', run = function() pcall(vim.cmd, 'TSUpdate') end }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'norcalli/nvim-colorizer.lua'

  -- Interface
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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

  if PACKER_BOOTSTRAP then
    -- init.lua skips every plugin's config on this launch, so say so inside
    -- nvim rather than leave a half-configured editor looking broken.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PackerComplete',
      once = true,
      callback = function()
        vim.notify('Plugins installed. Quit and reopen nvim to load them.', vim.log.levels.WARN)
      end,
    })
    require('packer').sync()
  end
end)
