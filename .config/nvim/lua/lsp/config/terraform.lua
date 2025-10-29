-- Author: Apache X692
-- Created on: 29/03/2025
--
-- LSP Configuration: Terraform
-- Referenced from:
-- 1. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/terraformls.lua
local lsp_root = require('lsp.root')

vim.lsp.config['terraform-ls'] = {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'tf', 'hcl', 'terraform-vars' },
  root_dir = lsp_root.make_root_dir('terraform'),
}

-- Enable
-- vim.lsp.enable('terraform-ls')
