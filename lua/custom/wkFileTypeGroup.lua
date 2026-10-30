-- lua/custom/wk.lua
local M = {}

---Register a which-key group only in buffers of the given filetypes.
---@param lhs string            keymap prefix, e.g. '<localleader>m'
---@param group string          group label, e.g. '[m]olten'
---@param fts string|string[]   filetype(s) to enable the group in
---@param opts? table           extra which-key spec fields (e.g. mode)
function M.ft_group(lhs, group, fts, opts)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = fts,
    callback = function(ev)
      require('which-key').add {
        vim.tbl_extend('force', { lhs, group = group, buffer = ev.buf }, opts or {}),
      }
    end,
  })
end

return M
