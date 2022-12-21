local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = { "shorten" },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<esc>'] = actions.close,
      }
    }
  }
}


local set = vim.api.nvim_set_keymap

-- set('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ff', require('telescope.builtin').find_files, { noremap = true })
-- set('n', '<Leader>ps', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fg', require('telescope.builtin').live_grep, { noremap = true })
vim.keymap.set('n', '<Leader>fb', require('telescope.builtin').buffers, { noremap = true })
vim.keymap.set('n', '<Leader>fh', require('telescope.builtin').help_tags, { noremap = true })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { noremap = true })
