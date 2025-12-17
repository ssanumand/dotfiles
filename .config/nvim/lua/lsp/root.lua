-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Shared Handlers for LSPs
local M = {}

local root_markers = {
  python = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
  },
  go = {
    'go.mod',
  },
  terraform = {
    '.terraform',
    '.git',
  },
  typescript = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
  },
  clangd = {
    'compile_commands.json',
    'compile_flags.txt',
    '.clangd',
    '.git',
  },
  zig = {
    'build.zig',
    'build.zig.zon',
    'zls.json',
  },
}

local function resolve_start_path(fname)
  local buffer_name = fname

  if type(buffer_name) == 'number' then
    if vim.api.nvim_buf_is_valid(buffer_name) then
      buffer_name = vim.api.nvim_buf_get_name(buffer_name)
    else
      buffer_name = nil
    end
  end

  if buffer_name == nil or buffer_name == '' then
    local current_buf = vim.api.nvim_get_current_buf()

    if vim.api.nvim_buf_is_valid(current_buf) then
      buffer_name = vim.api.nvim_buf_get_name(current_buf)
    end
  end

  if buffer_name == nil or buffer_name == '' then
    return vim.loop.cwd()
  end

  local directory = vim.fs.dirname(buffer_name)

  if directory == nil or directory == '' then
    return vim.loop.cwd()
  end

  return directory
end

local function path_exists(path)
  return path ~= nil and vim.loop.fs_stat(path) ~= nil
end

local function search_root(markers, start_path)
  if markers == nil or vim.tbl_isempty(markers) then
    return start_path
  end

  local current = start_path

  while current ~= nil and current ~= '' do
    for _, marker in ipairs(markers) do
      local marker_path = vim.fs.joinpath(current, marker)

      if path_exists(marker_path) then
        return current
      end
    end

    local parent = vim.fs.dirname(current)

    if parent == nil or parent == current then
      break
    end

    current = parent
  end

  return start_path
end

function M.get_markers(language)
  return root_markers[language]
end

function M.set_markers(language, markers)
  root_markers[language] = markers
end

function M.find_root(language, fname)
  local markers = root_markers[language]

  if markers == nil then
    return resolve_start_path(fname)
  end

  local start_path = resolve_start_path(fname)
  return search_root(markers, start_path)
end

function M.make_root_dir(language)
  return function(arg1, arg2)
    if type(arg2) == 'function' then
      local bufnr = arg1
      local on_dir = arg2
      local root_dir = M.find_root(language, bufnr)
      on_dir(root_dir)
      return root_dir
    end

    return M.find_root(language, arg1)
  end
end

return M
