return {
  'willyelm/pulse.nvim',
  lazy = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function()
    require('pulse').setup()
    vim.keymap.set('n', '<leader>p', '<cmd>Pulse<cr>', { desc = 'Pulse' })
  end,
}
