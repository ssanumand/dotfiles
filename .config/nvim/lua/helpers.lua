-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Global Helpers
local M = {}

local EXCLUDE_PATTERNS = {
  '.uv_cache',
  '.git',
  'node_modules',
  'venv',
  '.venv',
  '.idea',
  '.env',
  '__pycache__',
  '*.log',
  '*.pyc',
  '*.pyo',
  '*.out',
}

local function build_fd_args()
  local args = {
    'fd',
    '--type=f',
    '--hidden',
    '--strip-cwd-prefix',
    '--color=never',
  }

  for _, pattern in ipairs(EXCLUDE_PATTERNS) do
    table.insert(args, '--exclude=' .. pattern)
  end

  return args
end

local function build_rg_args(query)
  local args = {
    'rg',
    '--vimgrep',
    '--smart-case',
    '--hidden',
    '--color=never',
  }

  for _, pattern in ipairs(EXCLUDE_PATTERNS) do
    table.insert(args, '--glob')
    table.insert(args, '!' .. pattern)
  end

  table.insert(args, query)
  table.insert(args, '.')

  return args
end

local FD_ARGS = build_fd_args()

local function shell_join(args)
  local escaped = {}

  for _, arg in ipairs(args) do
    table.insert(escaped, vim.fn.shellescape(arg))
  end

  return table.concat(escaped, ' ')
end

local function fd_cache_dir()
  return vim.fs.joinpath(vim.fn.stdpath('state'), 'fd')
end

local function workspace_cache_key()
  local cwd = vim.loop.cwd() or vim.fn.getcwd()
  if not cwd or cwd == '' then
    return 'workspace'
  end
  return vim.fn.sha256(cwd):sub(1, 16) -- safe, short, unique
end

function M.get_fd_cache_path()
  return vim.fs.joinpath(fd_cache_dir(), workspace_cache_key() .. '.txt')
end

function M.get_fd_command_args()
  return vim.deepcopy(FD_ARGS)
end

function M.get_fd_command_string()
  return shell_join(M.get_fd_command_args())
end

function M.workspace_search()
  if vim.fn.executable('rg') == 0 then
    vim.notify('Not Found: ripgrep', vim.log.levels.ERROR)
    return
  end

  local query = vim.fn.input('Workspace Search: ')
  if not query or query == '' then
    vim.notify('Search Cancelled', vim.log.levels.INFO)
    return
  end

  local args = build_rg_args(query)
  local output = vim.fn.systemlist(args)
  local shell_error = vim.v.shell_error

  if shell_error > 1 then
    vim.notify('ripgrep Failed:\n' .. table.concat(output, '\n'), vim.log.levels.ERROR)
    return
  end

  local items = {}
  for _, line in ipairs(output) do
    local filename, lnum, col, text = line:match('^(.-):(%d+):(%d+):(.*)$')
    if filename then
      table.insert(items, {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = text,
      })
    end
  end

  if #items == 0 then
    vim.notify('No Workspace Matches', vim.log.levels.INFO)
    vim.cmd('cclose')
    return
  end

  vim.fn.setqflist({}, ' ', {
    title = 'Workspace Search: ' .. query,
    items = items,
  })
  vim.cmd('copen')
end

local function write_cache(lines, path)
  local ok, err = pcall(vim.fn.writefile, lines, path)
  if not ok then return false, err end
  return true
end

function M.ensure_fd_cache(opts)
  opts = opts or {}
  local cache_path = M.get_fd_cache_path()
  vim.fn.mkdir(fd_cache_dir(), 'p')

  if not opts.force then
    local stat = vim.loop.fs_stat(cache_path)
    if stat and stat.type == 'file' then
      return cache_path
    end
  end

  if vim.fn.executable('fd') == 0 then
    if not opts.silent then
      vim.notify('Not Found: fd', vim.log.levels.ERROR)
    end
    return nil
  end

  local result = vim.fn.systemlist(M.get_fd_command_args())
  if vim.v.shell_error ~= 0 then
    if not opts.silent then
      vim.notify('Cache Generation Failed:\n' .. table.concat(result, '\n'), vim.log.levels.ERROR)
    end
    return nil
  end

  local ok, err = write_cache(result, cache_path)
  if not ok then
    if not opts.silent then
      vim.notify('Failed to Write fd Cache: ' .. err, vim.log.levels.ERROR)
    end
    return nil
  end

  if not opts.silent then
    vim.notify('FZF Cache Refreshed', vim.log.levels.INFO)
  end

  return cache_path
end

function M.format_with_prettier()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)

  if filepath == '' then
    vim.notify('Invalid File Path', vim.log.levels.ERROR)
    return
  end

  if vim.bo.modified then
    vim.notify('Save File (before formatting)', vim.log.levels.WARN)
    return
  end

  local result = vim.fn.system({ 'prettier', '--write', filepath })
  if vim.v.shell_error ~= 0 then
    vim.notify('Prettier Failed:\n' .. result, vim.log.levels.ERROR)
  else
    vim.notify('Formatted with Prettier', vim.log.levels.INFO)
    -- Reload File
    vim.cmd('edit!')
  end
end

return M
