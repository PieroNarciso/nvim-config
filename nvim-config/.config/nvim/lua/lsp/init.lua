require('mason').setup()

local opts = { noremap = true, silent = true }

-- Mappings
-- buf_set_keymap('n', '<Leader>ft', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)


local servers = {
  'ts_ls', 'vuels', 'pyright', 'html', 'dockerls', 'tailwindcss',
  'yamlls', 'diagnosticls', 'cssls', 'gopls', 'lua_ls', 'solargraph',
  'svelte'
}

require('mason-lspconfig').setup {
  ensure_installed = servers,
  -- automatic_installation = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback =  function(event)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = event.buf }

    -- Set some keybinds conditional on server capabilities
    vim.keymap.set('n', '<Leader>sd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<Leader>ft', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references
      })
    end
  end

})

-- vim.diagnostic.config({
--   virtual_text = true,
--   virtual_lines = true,
-- })
