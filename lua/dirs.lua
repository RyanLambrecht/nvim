-- lua/dirs.lua
-- Machine-specific working directories used by pickers/dashboard keybinds.
-- Edit these to fit your system
return {
  code = vim.fn.expand '~/code/',
  notes = vim.fn.expand '~/notes/',
  dev = vim.fn.expand '~/dev/',
}
