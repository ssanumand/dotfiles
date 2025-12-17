-- Author: Apache X692
-- Created on: 31/10/2025
--
-- LSP Configuration: Clangd
-- Referenced from:
-- 1. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/clangd.lua
local lsp_root = require('lsp.root')

vim.lsp.config['clangd'] = {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_dir = lsp_root.make_root_dir('clangd'),
  single_file_support = true,
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
}

-- Enable
-- vim.lsp.enable('clangd')
