-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({
  paths = vim.fn.stdpath "config" .. "/lua/snippets"
})
