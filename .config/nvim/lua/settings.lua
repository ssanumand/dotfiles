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

-- Colors and Appearance
vim.cmd('filetype indent on')

-- Override Styling
vim.api.nvim_set_hl(0, 'Comment', { italic = true })

-- Italicize String Literals
local string_hl = vim.api.nvim_get_hl(0, { name = 'String', link = false })
string_hl.italic = true
string_hl.fg = '#808080'
vim.api.nvim_set_hl(0, 'String', string_hl)

-- Environment Variables (FZF)
local fd_cache_path = helpers.ensure_fd_cache({ silent = true })
if fd_cache_path then
    vim.env.FZF_DEFAULT_COMMAND = 'cat ' .. vim.fn.shellescape(fd_cache_path)
else
    vim.env.FZF_DEFAULT_COMMAND = helpers.get_fd_command_string()
end
vim.g.fzf_action = { ['enter'] = 'edit' }
