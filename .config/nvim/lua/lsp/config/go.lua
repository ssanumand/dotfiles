-- Author: Apache X692
-- Created on: 29/03/2025
--
-- LSP Configuration: Go
-- Referenced from:
-- 1. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/pyright.lua
local lsp_root = require('lsp.root')

vim.lsp.config['gopls'] = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = lsp_root.make_root_dir('go'),
}

-- Enable
-- vim.lsp.enable('gopls')
