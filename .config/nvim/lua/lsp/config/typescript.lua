-- Author: Apache X692
-- Created on: 31/03/2025
--
-- LSP Configuration: TypeScript
-- Referenced from:
-- 1. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/tsserver.lua
-- 2. https://github.com/typescript-language-server/typescript-language-server#configuration
local lsp_root = require('lsp.root')

vim.lsp.config['typescript-language-server'] = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_dir = lsp_root.make_root_dir('typescript'),
  single_file_support = false,
  settings = {
    javascript = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative',
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative',
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },
}

-- Enable
-- vim.lsp.enable('typescript-language-server')
