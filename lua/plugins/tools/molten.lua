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
    { '<localleader>mi', ':MoltenInit<CR>', desc = 'Init Molten kernel' },
    { '<localleader>me', ':MoltenEvaluateOperator<CR>', desc = 'Evaluate operator' },
    { '<localleader>ml', ':MoltenEvaluateLine<CR>', desc = 'Evaluate line' },
    { '<localleader>mc', ':MoltenReevaluateCell<CR>', desc = 'Re-eval cell' },
    { '<localleader>mo', ':MoltenShowOutput<CR>', desc = 'Show output' },
  },
}

-- Come back to this and figure out how you could use it to rended latex and such cause that would be awesome and yeah
