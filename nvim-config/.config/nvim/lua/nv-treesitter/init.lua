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
  },
  context_commentstring = {
    enable = true
  }
}
