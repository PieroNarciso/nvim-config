require('plugins')
-- First launch on a new machine: every module below requires a plugin that
-- packer is still installing. Restart nvim once the sync finishes.
if PACKER_BOOTSTRAP then
  return
end
require('keymap')
require('config')
require('colorscheme')

-- Plugins
require('nv-luasnip')
require('nv-treesitter')
require('nv-fzf')
require('nv-lualine')
require('nv-blankline')
-- require('nv-tabline')
require('nv-gitsings')
require('nv-tree')
-- require('nv-presence')
require('nv-colorizer')
require('nv-telescope')
require('nv-autopairs')
require('nv-cmp')
require('nv-autotag')
-- require('nv-formatter')
-- require('nv-copilot')
-- require('nv-dap')
-- require('nv-dap-ui')

-- LSP
require('lsp')
