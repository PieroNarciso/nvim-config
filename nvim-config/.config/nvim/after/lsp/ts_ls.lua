-- Hybrid-mode Vue support. vue_ls (Volar 3.x) dropped takeover mode, so the
-- TypeScript inside a .vue file is served by ts_ls running the
-- @vue/typescript-plugin rather than by vue_ls itself. The plugin ships inside
-- the mason `vue-language-server` package; ts_ls must also claim the `vue`
-- filetype or the plugin never loads.
--
-- Files under after/lsp/<name>.lua must RETURN a config table; Nvim merges it
-- over nvim-lspconfig's shipped lsp/ts_ls.lua when a client is enabled.
local vue_language_server = vim.fn.stdpath('data')
  .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
}
