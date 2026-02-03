return {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
  root_dir = require('lspconfig/util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
}
