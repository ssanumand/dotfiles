
-- Author: Apache X692
-- Created on: 29/03/2025
--
-- Global Helpers
local M = {}

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
