return {
  'nvim-telescope/telescope-symbols.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  cmd = 'Telescope',
  keys = {
    {
      '<C-u>',
      "<cmd>lua require('telescope-symbols').symbols({ sources = {'math','devicons','git','misc'}, prompt_title = 'Insert Symbol' })<CR>",
      mode = 'i',
      desc = 'Insert Symbol',
    },
  },
}
