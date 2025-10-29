-- Author: Apache X692
-- Created on: 29/03/2025

local helpers = require('helpers')

-- netrw Behavior
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Core Editor Behavior
vim.opt.compatible = false
vim.opt.wildmenu = true
vim.opt.wrap = true
vim.opt.hlsearch = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.smartindent = true
vim.opt.ignorecase = true

-- Visual Guides
vim.opt.colorcolumn = '90'

-- Completion Behavior
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'popup' }

-- Short Messages
vim.opt.shortmess:append('I')

vim.cmd('filetype indent on')

-- Environment Variables (FZF)
local fd_cache_path = helpers.ensure_fd_cache({ silent = true })
if fd_cache_path then
    vim.env.FZF_DEFAULT_COMMAND = 'cat ' .. vim.fn.shellescape(fd_cache_path)
else
    vim.env.FZF_DEFAULT_COMMAND = helpers.get_fd_command_string()
end
vim.g.fzf_action = { ['enter'] = 'edit' }

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'python', 'lua', 'javascript', 'html', 'css',
    'bash', 'json', 'yaml', 'markdown', 'go',
  },
  incremental_selection = { enable = false },
  highlight = { enable = true },
  additional_vim_regex_highlighting = false,
}

-- nvim-github-theme
require('github-theme').setup({
  options = {
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = 'italic',
      strings  = 'italic',
      keywords = 'bold',
      functions = 'NONE',
      variables = 'NONE',
    },
    additional_vim_regex_highlighting = false,
  }
})
vim.cmd('colorscheme github_light_default')
