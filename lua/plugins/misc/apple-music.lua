return {
  'p5quared/apple-music.nvim',
  -- Optional dependencies (install one of the supported pickers, e.g., 'nvim-telescope/telescope.nvim' for Telescope or 'ibhagwan/fzf-lua' for fzf-based picker)
  dependencies = {
    'nvim-telescope/telescope.nvim',
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
      '<leader>ms',
      function()
        require('apple-music').toggle_shuffle()
      end,
      desc = 'Toggle [S]huffle',
    },
    {
      '<leader>mfp',
      function()
        require('apple-music').select_playlist()
      end,
      desc = '[F]ind [P]laylists',
    },
    {
      '<leader>mfa',
      function()
        require('apple-music').select_album()
      end,
      desc = '[F]ind [A]lbum',
    },
    {
      '<leader>mfs',
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
        require('apple-music').previous_track()
      end,
      desc = '[ ]ext track',
    },
  },
}
