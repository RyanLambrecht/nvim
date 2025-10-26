return {
  -- Main vim-airline plugin
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      -- Use powerline fonts if available
      vim.g.airline_powerline_fonts = 1

      -- Pick a theme that matches kickstart.nvim's default (dark background)
      vim.g.airline_theme = 'deus'

      -- Detect background automatically (optional)
      vim.g.airline_detect_background = 1
    end,
  },

  -- Optional clock for airline statusline
  {
    'enricobacis/vim-airline-clock',
    dependencies = { 'vim-airline/vim-airline' },
    config = function()
      -- Clock format (24-hour)
      vim.g['airline#extensions#clock#format'] = '%H:%M'
      -- Update interval in milliseconds
      vim.g['airline#extensions#clock#updatetime'] = 1000
    end,
  },
}
