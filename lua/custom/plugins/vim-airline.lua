return {
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },

    init = function()
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = 'deus'
      vim.g.airline_detect_background = 1

      -- disable the tabline close button (the "x")
      vim.g['airline#extensions#tabline#show_close_button'] = 0
    end,
  },

  {
    'enricobacis/vim-airline-clock',
    dependencies = { 'vim-airline/vim-airline' },
    config = function()
      vim.g['airline#extensions#clock#format'] = '%H:%M'
      vim.g['airline#extensions#clock#updatetime'] = 1000
    end,
  },
}
