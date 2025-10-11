-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Keymaps Configuration
local helpers = require('helpers')

vim.g.mapleader = ' '

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File Tree
keymap('n', '<leader>en', ':Ex<CR>', opts)
keymap('n', '<leader>ef', ':FZF<CR>', opts)

-- File Operations
keymap('n', '<leader>r', ':%s//g<Left><Left>', { noremap = true })

-- Buffer Management
keymap('n', '<Tab>', ':bn<CR>', opts)
keymap('n', '<S-Tab>', ':bp<CR>', opts)

-- Tab Management
keymap('n', '<leader>t', ':tabnew<CR>', opts)
keymap('n', '<leader>td', ':tabclose<CR>', opts)
keymap('n', '<leader>tp', ':tabprevious<CR>', opts)
keymap('n', '<leader>tn', ':tabnext<CR>', opts)

-- Split Management
keymap('n', '<leader>h', ':split<CR>', opts)
keymap('n', '<leader>v', ':vsplit<CR>', opts)

-- Windows: Focus Selection
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

-- Quick Fix List
keymap('n', '<leader>qc', ':cclose<CR>', opts)

-- Location List
keymap('n', '<leader>lc', ':lclose<CR>', opts)

-- LSP
-- Diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>dl', vim.diagnostic.setloclist, opts)

-- LSP Commands
keymap('n', 'gS', ':lua vim.lsp.buf.workspace_symbol("")<Left><Left>', { noremap = true }) -- Workspace Symbols
keymap('n', 'K', vim.lsp.buf.hover, opts) -- Symbol Definition

-- LSP Commands: Definition and Declarations
keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'gD', vim.lsp.buf.declaration, opts)

-- LSP Commands: Formatting
keymap('n', '<leader>fl', vim.lsp.buf.format, opts) -- LSP Formatting
keymap('n', '<leader>fp', helpers.format_with_prettier, opts)

-- Copy Relative Path of Active Buffer to Clipboard
keymap('n', '<leader>cr', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end)
