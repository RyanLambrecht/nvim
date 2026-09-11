local M = {}
local ns = vim.api.nvim_create_namespace 'bounded_cursorline'
local mark = nil
local mark_buf = nil
local function clear()
  if mark and mark_buf and vim.api.nvim_buf_is_valid(mark_buf) then
    pcall(vim.api.nvim_buf_del_extmark, mark_buf, ns, mark)
  end
  mark = nil
  mark_buf = nil
end
local function is_normal_buffer(buf)
  -- Only operate on normal file buffers.
  if vim.bo[buf].buftype ~= '' then
    return false
  end
  -- Snacks dashboard uses a normal buftype.
  if vim.bo[buf].filetype == 'snacks_dashboard' then
    return false
  end
  return true
end
local function in_visual_mode()
  local mode = vim.fn.mode()
  return mode == 'v' or mode == 'V' or mode == '\22' -- v, V, CTRL-V
end
local function update()
  clear()
  local win = vim.api.nvim_get_current_win()
  -- Only show in the active window.
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  -- Don't interfere with floating windows.
  local config = vim.api.nvim_win_get_config(win)
  if config.relative ~= '' then
    return
  end
  local buf = vim.api.nvim_win_get_buf(win)
  if not is_normal_buffer(buf) then
    return
  end
  -- Don't paint the cursorline in visual mode; let the native
  -- Visual highlight show only what's actually selected.
  if in_visual_mode() then
    return
  end
  local row = vim.api.nvim_win_get_cursor(win)[1] - 1
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1]
  -- Don't highlight empty lines.
  if not line or #line == 0 then
    return
  end
  mark = vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
    end_col = #line,
    hl_group = 'CursorLine',
    hl_eol = false,
  })
  mark_buf = buf
end
function M.setup()
  -- Disable Neovim's native full-width cursorline.
  vim.opt.cursorline = false
  vim.api.nvim_create_autocmd({
    'CursorMoved',
    'CursorMovedI',
    'WinEnter',
    'BufEnter',
    'ModeChanged',
  }, {
    callback = update,
  })
  vim.api.nvim_create_autocmd('WinLeave', {
    callback = clear,
  })
  update()
end
return M
