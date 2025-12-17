-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Keymaps Configuration
local helpers = require('helpers')

vim.g.mapleader = ' '

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File Tree
keymap('n', '<leader>en', '<cmd>Ex<CR>', opts)
keymap('n', '<leader>ef', '<cmd>FZF<CR>', opts)

-- File Operations
keymap('n', '<leader>r', ':%s//g<Left><Left>', { noremap = true })
keymap('n', '<leader>fw', helpers.workspace_search, opts)

-- Buffer Management
keymap('n', '<Tab>', '<cmd>bn<CR>', opts)
keymap('n', '<S-Tab>', '<cmd>bp<CR>', opts)

-- Tab Management
keymap('n', '<leader>t', '<cmd>tabnew<CR>', opts)
keymap('n', '<leader>td', '<cmd>tabclose<CR>', opts)
keymap('n', '<leader>tp', '<cmd>tabprevious<CR>', opts)
keymap('n', '<leader>tn', '<cmd>tabnext<CR>', opts)

-- Split Management
keymap('n', '<leader>h', '<cmd>split<CR>', opts)
keymap('n', '<leader>v', '<cmd>vsplit<CR>', opts)

-- Windows: Focus Selection
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

-- Quick Fix List
keymap('n', '<leader>qc', '<cmd>cclose<CR>', opts)
keymap('n', ']q', '<cmd>cnext<CR>')
keymap('n', '[q', '<cmd>cprevious<CR>')

-- Location List
keymap('n', '<leader>lc', '<cmd>lclose<CR>', opts)
keymap('n', ']l', '<cmd>lnext<CR>')
keymap('n', '[l', '<cmd>lprevious<CR>')

-- LSP
-- Diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>dl', vim.diagnostic.setloclist, opts)

-- LSP Commands
keymap('n', 'gS', ':lua vim.lsp.buf.workspace_symbol("")<Left><Left>', { noremap = true }) -- Workspace Symbols

-- LSP Commands: Definition and Declarations
keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'gD', vim.lsp.buf.declaration, opts)

-- LSP Commands: Symbol Definition and Signature Help
keymap('n', 'K', function()
  vim.lsp.buf.hover({ border = 'rounded', focusable = true })
end, { silent = true })

keymap({ 'n', 'i' }, '<C-s>', function()
  vim.lsp.buf.signature_help({ border = 'rounded', focusable = true })
end, { silent = true })

-- LSP Commands: Formatting
keymap('n', '<leader>fl', vim.lsp.buf.format, opts) -- LSP Formatting
keymap('n', '<leader>fp', helpers.format_with_prettier, opts)

-- Copy Relative Path of Active Buffer to Clipboard
keymap('n', '<leader>cr', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end)
