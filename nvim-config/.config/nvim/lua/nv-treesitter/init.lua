require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true,
    disable = {
      'lua',
      'typescript',
      'cpp',
      'yaml',
      'python',
      'go',
      'ruby',
      'html'
    }
  }
}

vim.g.skip_ts_context_commentstring_module = true

require'ts_context_commentstring'.setup {
  enable_autocmd = false,
}
