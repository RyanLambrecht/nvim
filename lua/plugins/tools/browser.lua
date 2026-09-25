return {
  'aliqyan-21/wit.nvim',
  keys = {
    { '<leader>sb', ':WitSearch<CR>', mode = 'n', desc = '[B]rowser: Search' },
    { '<leader>sb', ':WitSearchVisual<CR>', mode = 'v', desc = '[B]rowser: Search visual' },
  },
  config = function()
    require('wit').setup()
  end,
}
