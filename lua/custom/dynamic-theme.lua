local M = {}

----------------------------------------------------------------------
-- State
----------------------------------------------------------------------

local accent -- last synced accent colour, reused when NeoColumn redraws

----------------------------------------------------------------------
-- Terminal Cursor
----------------------------------------------------------------------

local function osc12(hex)
  io.write(string.format('\027]12;%s\007', hex))
end

local function osc112_reset()
  io.write '\027]112\007'
end

----------------------------------------------------------------------
-- Highlight Helpers
----------------------------------------------------------------------

local function hex_from_value(value)
  return value and string.format('#%06x', value) or nil
end

local function hex_from_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  return hex_from_value(hl.bg or hl.fg)
end

local function normal_bg()
  -- transparent themes have Normal.bg = nil, so fall back to a dark base
  return hex_from_value(vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg) or '#000000'
end

local function parse_hex(hex)
  hex = hex:gsub('#', '')

  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function blend(fg_hex, bg_hex, alpha)
  local fr, fg, fb = parse_hex(fg_hex)
  local br, bg, bb = parse_hex(bg_hex)

  local function mix(f, b)
    return math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end

  return string.format('#%02x%02x%02x', mix(fr, br), mix(fg, bg), mix(fb, bb))
end

----------------------------------------------------------------------
-- Visual
----------------------------------------------------------------------

local VISUAL_SOURCES = { 'Function', 'Statement', 'String' }
local VISUAL_ALPHA = 0.35
local NEOCOLUMN_ALPHA = 0.50

local function sync_visual()
  local hex

  for _, name in ipairs(VISUAL_SOURCES) do
    hex = hex_from_hl(name)

    if hex then
      break
    end
  end

  if hex then
    vim.api.nvim_set_hl(0, 'Visual', {
      bg = blend(hex, normal_bg(), VISUAL_ALPHA),
    })
  end
end

----------------------------------------------------------------------
-- NeoColumn
----------------------------------------------------------------------

-- NeoColumn draws with the ColorColumn group and redefines it (from IncSearch
-- or its config) on every Filetype/BufEnter/BufWinEnter, so we re-apply after it.
local function sync_neocolumn()
  if not accent then
    return
  end

  vim.api.nvim_set_hl(0, 'ColorColumn', {
    bg = blend(accent, normal_bg(), NEOCOLUMN_ALPHA),
  })
end

----------------------------------------------------------------------
-- Cursor Colour
----------------------------------------------------------------------

local function sync_cursor_color(colorscheme_name)
  if colorscheme_name == nil or colorscheme_name == 'default' then
    osc112_reset()
    return
  end

  local hex = hex_from_hl 'Type' or hex_from_hl 'Special'

  if hex then
    accent = hex
    osc12(hex)
    sync_visual()
    sync_neocolumn()
  end
end

----------------------------------------------------------------------
-- Themery
----------------------------------------------------------------------

-- run a before/after code string saved by themery
local function run(code)
  if type(code) == 'string' and code ~= '' then
    local fn = load(code)

    if fn then
      pcall(fn)
    end
  end
end

----------------------------------------------------------------------
-- Autocommands
----------------------------------------------------------------------

-- autocmds must exist BEFORE the saved theme is applied so its
-- ColorScheme event gets caught
function M.setup()
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      if vim.bo.buftype ~= 'terminal' then
        sync_cursor_color(vim.g.colors_name)
      end
    end,
  })

  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function(ev)
      if ev.match ~= 'default' then
        vim.cmd 'syntax on'
      end

      sync_cursor_color(ev.match)
    end,
  })

  -- run after NeoColumn's own handlers so our ColorColumn wins
  vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'BufWinEnter' }, {
    callback = function()
      vim.schedule(sync_neocolumn)
    end,
  })

  vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, {
    callback = osc112_reset,
  })
end

----------------------------------------------------------------------
-- Saved Theme
----------------------------------------------------------------------

-- replaces themery's startup persistence (same order themery uses)
function M.apply_saved_theme()
  local f = io.open(vim.fn.stdpath 'data' .. '/themery/state.json', 'r')

  if not f then
    return
  end

  local ok, state = pcall(vim.json.decode, f:read '*a')
  f:close()

  if ok and type(state) == 'table' and state.colorscheme then
    run(state.globalBeforeCode)
    run(state.beforeCode)
    pcall(vim.cmd.colorscheme, state.colorscheme)
    run(state.afterCode)
    run(state.globalAfterCode)
  end
end

----------------------------------------------------------------------
-- ColorScheme Autocommand
----------------------------------------------------------------------

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function(ev)
    if ev.match ~= 'default' then
      vim.cmd 'syntax on'
    end

    sync_cursor_color(ev.match)

    vim.schedule(function()
      sync_cursor_color(ev.match)
    end)
  end,
})

return M
