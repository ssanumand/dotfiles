-- Author: Apache X692
-- Created on: 31/10/2025
--
-- LSP Configuration: Zig
-- Referenced from:
-- 1. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/zls.lua
local lsp_root = require('lsp.root')

vim.lsp.config['zls'] = {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_dir = lsp_root.make_root_dir('zig'),
  single_file_support = true,
}

-- Enable
-- vim.lsp.enable('zls')
