vim.g.mapleader = " "

-- Unbind some useless/annoying default key bindings
vim.keymap.set('n', 'Q', '<Nop>', { noremap = false })

-- Move between vim buffers
-- set('n', '<Tab>', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true })

-- Visual map for maintain Visual Mode after shifting > and <
vim.keymap.set('v', '<', '<gv', {})
vim.keymap.set('v', '>', '>gv', {})

-- Close current buffer
vim.keymap.set('n', '<Leader>cb', ':bdelete<CR>', {})

-- Select all buffer
vim.keymap.set('n', '<Leader>a', 'ggVG', {})

-- Search mapping: Center next and previous search
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })


vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
