require('mason').setup()

local opts = { noremap = true, silent = true }

-- Mappings
-- buf_set_keymap('n', '<Leader>ft', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.keymap.set('n', '<Leader>sd', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)


local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Set some keybinds conditional on server capabilities
  vim.keymap.set('n', '<Leader>ft', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

end

local servers = {
  'tsserver', 'vuels', 'pyright', 'html', 'dockerls', 'tailwindcss',
  'yamlls', 'diagnosticls', 'cssls', 'gopls', 'lua_ls', 'solargraph',
  'svelte'
}

require('mason-lspconfig').setup {
  ensure_installed = servers,
  -- automatic_installation = true,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


require("mason-lspconfig").setup_handlers {
  function(server_name)
    local config = {}

    if server_name == 'tsserver' then
      config = require 'lsp.tsserver'
    elseif server_name == 'vuels' then
      config = require 'lsp.vue'
    elseif server_name == 'pyright' then
      config = require 'lsp.python'
    elseif server_name == 'html' then
      config = require 'lsp.html'
    elseif server_name == 'cssls' then
      config = require 'lsp.css'
    elseif server_name == 'sumneko_lua' then
      config = require 'lsp.lua'
    elseif server_name == 'dockerls' then
      config = require 'lsp.docker'
    elseif server_name == 'tailwindcss' then
      config = require 'lsp.tailwindcss'
    elseif server_name == 'vimls' then
      config = require 'lsp.vim'
    elseif server_name == 'yamlls' then
      config = require 'lsp.yaml'
    elseif server_name == 'diagnosticls' then
      config = require 'lsp.diagnosticls'
    elseif server_name == 'denols' then
      config = require 'lsp.deno'
    end
    if not config.root_dir then
      config.root_dir = function() return vim.fn.getcwd() end
    end

    config.on_attach = on_attach
    config.capabilities = capabilities
    config.flags = { debounce_text_changes = 150 }
    require('lspconfig')[server_name].setup(config)
  end
}

for _, server in pairs(servers) do
  local config = {}

  if server == 'tsserver' then
    config = require 'lsp.tsserver'
  elseif server == 'vuels' then
    config = require 'lsp.vue'
  elseif server == 'pyright' then
    config = require 'lsp.python'
  elseif server == 'html' then
    config = require 'lsp.html'
  elseif server == 'cssls' then
    config = require 'lsp.css'
  elseif server == 'sumneko_lua' then
    config = require 'lsp.lua'
  elseif server == 'dockerls' then
    config = require 'lsp.docker'
  elseif server == 'tailwindcss' then
    config = require 'lsp.tailwindcss'
  elseif server == 'vimls' then
    config = require 'lsp.vim'
  elseif server == 'yamlls' then
    config = require 'lsp.yaml'
  elseif server == 'diagnosticls' then
    config = require 'lsp.diagnosticls'
  elseif server == 'denols' then
    config = require 'lsp.deno'
  end
  if not config.root_dir then
    config.root_dir = function() return vim.fn.getcwd() end
  end

  config.on_attach = on_attach
  config.capabilities = capabilities
  config.flags = { debounce_text_changes = 150 }
  require('lspconfig')[server].setup(config)
end
