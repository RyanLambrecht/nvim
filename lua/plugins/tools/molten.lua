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
    { '<localleader>mi', ':MoltenInit<CR>', ft = { 'python', 'markdown' }, desc = 'Init Molten kernel' },
    { '<localleader>me', ':MoltenEvaluateOperator<CR>', ft = { 'python', 'markdown' }, desc = 'Evaluate operator' },
    { '<localleader>ml', ':MoltenEvaluateLine<CR>', ft = { 'python', 'markdown' }, desc = 'Evaluate line' },
    { '<localleader>mc', ':MoltenReevaluateCell<CR>', ft = { 'python', 'markdown' }, desc = 'Re-eval cell' },
    { '<localleader>mo', ':MoltenShowOutput<CR>', ft = { 'python', 'markdown' }, desc = 'Show output' },
    { '<localleader>mv', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', ft = { 'python', 'markdown' }, desc = 'Evaluate selection' },
  },
}
