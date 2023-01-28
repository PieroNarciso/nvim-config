local dap = require('dap')

vim.keymap.set('n', '<leader>dp', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>dc', ':lua require("dap").continue()<CR>')
vim.keymap.set('n', '<leader>di', ':lua require("dap").step_into()<CR>')
vim.keymap.set('n', '<leader>do', ':lua require("dap").step_over()<CR>')


dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/bin/dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  }
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}
