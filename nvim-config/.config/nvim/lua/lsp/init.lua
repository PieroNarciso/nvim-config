local function buf_set_keymap(...) vim.api.nvim_set_keymap(...) end

local opts = { noremap = true, silent = true }

-- Mappings
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<Leader>ft', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<Leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)


local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

 -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#4c4c4c
      hi LspReferenceText cterm=bold ctermbg=red guibg=#4c4c4c
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#4c4c4c
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local servers = {
  'tsserver', 'vuels', 'pyright', 'html', 'dockerls', 'vimls', 'tailwindcss',
  'yamlls', 'diagnosticls', 'cssls', 'denols', 'sumneko_lua', 'gopls'
}

require('nvim-lsp-installer').setup {
  ensure_installed = servers,
  -- automatic_installation = true,
}

require('lspconfig').solargraph.setup{}
require('lspconfig').svelte.setup{}
require('lspconfig').clangd.setup{}

for _, server in pairs(servers) do
  local config = {}

  if server == 'tsserver' then
    config = require'lsp.tsserver'
  elseif server == 'vuels' then
    config = require'lsp.vue'
  -- elseif server.name == 'solargraph' then
  --   config = require'lsp.ruby'
  elseif server == 'pyright' then
    config = require'lsp.python'
  elseif server == 'html' then
    config = require'lsp.html'
  elseif server == 'cssls' then
    config = require'lsp.css'
  elseif server == 'sumneko_lua' then
    config = require'lsp.lua'
  elseif server == 'dockerls' then
    config = require'lsp.docker'
  elseif server == 'tailwindcss' then
    config = require'lsp.tailwindcss'
  elseif server == 'vimls' then
    config = require'lsp.vim'
  elseif server == 'yamlls' then
    config = require'lsp.yaml'
  elseif server == 'diagnosticls' then
    config = require'lsp.diagnosticls'
  elseif server == 'denols' then
    config = require'lsp.deno'
  -- elseif server == 'clangd' then
  --   config = require'lsp.cpp'
  end
  if not config.root_dir then
    config.root_dir = function () return vim.fn.getcwd() end
  end

  config.on_attach = on_attach
  require('lspconfig')[server].setup(config)
end

