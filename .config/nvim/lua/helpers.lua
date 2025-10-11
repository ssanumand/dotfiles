
-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Global Helpers
local M = {}

local FD_ARGS = {
  "fd",
  "--type=f",
  "--hidden",
  "--strip-cwd-prefix",
  "--color=never",
  "--exclude=.uv_cache",
  "--exclude=.git",
  "--exclude=node_modules",
  "--exclude=venv",
  "--exclude=.venv",
  "--exclude=.idea",
  "--exclude=.env",
  "--exclude=__pycache__",
  "--exclude=*.log",
  "--exclude=*.pyc",
  "--exclude=*.pyo",
  "--exclude=*.out",
}

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

  if filepath == "" then
    vim.notify("Invalid File Path", vim.log.levels.ERROR)
    return
  end

  if vim.bo.modified then
    vim.notify("Save File (before formatting)", vim.log.levels.WARN)
    return
  end

  local result = vim.fn.system({ "prettier", "--write", filepath })
  if vim.v.shell_error ~= 0 then
    vim.notify("Prettier Failed:\n" .. result, vim.log.levels.ERROR)
  else
    vim.notify("Formatted with Prettier", vim.log.levels.INFO)
    -- Reload File
    vim.cmd("edit!")
  end
end

return M
