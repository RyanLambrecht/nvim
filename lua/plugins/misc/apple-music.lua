return {
  'p5quared/apple-music.nvim',
  cond = vim.fn.has 'mac' == 1,
  -- Optional dependencies (install one of the supported pickers, e.g., 'nvim-telescope/telescope.nvim' for Telescope or 'ibhagwan/fzf-lua' for fzf-based picker)
  lazy = true,
  dependencies = {
    { 'nvim-telescope/telescope.nvim', lazy = true },
    --   'ibhagwan/fzf-lua',
  },
  config = true,
  keys = {
    {
      '<leader>mt',
      function()
        require('apple-music').toggle_play()
      end,
      desc = '[t]oggle Playback',
    },
    {
      '<leader>mS',
      function()
        require('apple-music').toggle_shuffle()
      end,
      desc = 'Toggle [S]huffle',
    },
    {
      '<leader>msp',
      function()
        require('apple-music').select_playlist()
      end,
      desc = '[F]ind [P]laylists',
    },
    {
      '<leader>msa',
      function()
        require('apple-music').select_album()
      end,
      desc = '[F]ind [A]lbum',
    },
    {
      '<leader>mss',
      function()
        require('apple-music').select_track()
      end,
      desc = '[F]ind [S]ong',
    },
    {
      '<leader>mx',
      function()
        require('apple-music').cleanup_all()
      end,
      desc = 'Cleanup Temp Playlists',
    },
    {
      '<leader>mp',
      function()
        require('apple-music').previous_track()
      end,
      desc = '[p]revious track',
    },
    {
      '<leader>mn',
      function()
        require('apple-music').next_track()
      end,
      desc = '[n]ext track',
    },
  },
}
