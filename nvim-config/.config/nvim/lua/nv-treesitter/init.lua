-- require('nvim-treesitter').setup {
--   -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
--   install_dir = vim.fn.stdpath('data') .. '/site'
-- }

-- require('nvim-treesitter').install {
--   'svelte',
--   'vue',
--   'typescript',
--   'javascript',
--   'tsx',
--   'jsx',
--   'json',
--   'html'
-- }

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'svelte',
    'vue',
    'typescript',
    'javascript',
    'tsx',
    'jsx',
    'javascriptreact',
    'typescriptreact',
    'json',
    'html',
    'go'
  },
  callback = function() vim.treesitter.start() end
})

require('treesitter-context').setup {
  enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false,      -- Enable multiwindow support.
  max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.g.skip_ts_context_commentstring_module = true

require 'ts_context_commentstring'.setup {
  enable_autocmd = false,
}
