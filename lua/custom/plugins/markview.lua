-- For `plugins/markview.lua` users.
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  opts = {
    renderer = {
      max_width = nil, -- disables line-length warnings
    },
  },

  -- Completion for `blink.cmp`
  -- dependencies = { "saghen/blink.cmp" },
}
