---@type LazySpec
return {
  'folke/snacks.nvim',
  opts = {
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = true, -- leave diagnostics alone
        inlay_hints = true,
      },
      center = false, -- center the window
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      win = { style = 'zen', width = 120, col = 0 },
    },
  },
}
