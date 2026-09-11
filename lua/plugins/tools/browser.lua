return {
  'aliqyan-21/wit.nvim',
  config = function()
    require('wit').setup()
    vim.keymap.set('n', '<leader>sb', ':WitSearch<CR>', { desc = '[B]rowser: Search' })
    vim.keymap.set('v', '<leader>sb', ':WitSearchVisual<CR>', { desc = '[B]rowser: Search visual' })
    -- vim.keymap.set('n', '<leader>ww', ':WitSearchWiki<CR>', { desc = 'Web: Search Wikipedia' })
  end,
}
