---@type LazySpec
return {
  'benlubas/molten-nvim',
  version = '^1.0.0',
  dependencies = { 'willothy/wezterm.nvim' },
  build = ':UpdateRemotePlugins',
  init = function()
    vim.g.molten_image_provider = 'wezterm.nvim'
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
  end,
  keys = {
    { '<leader>mi', ':MoltenInit<CR>', desc = 'Init Molten kernel' },
    { '<leader>me', ':MoltenEvaluateOperator<CR>', desc = 'Evaluate operator' },
    { '<leader>ml', ':MoltenEvaluateLine<CR>', desc = 'Evaluate line' },
    { '<leader>mc', ':MoltenReevaluateCell<CR>', desc = 'Re-eval cell' },
    { '<leader>mo', ':MoltenShowOutput<CR>', desc = 'Show output' },
  },
}

-- Come back to this and figure out how you could use it to rended latex and such cause that would be awesome and yeah
