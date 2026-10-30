return {
  'linux-cultist/venv-selector.nvim',
  ft = 'python',
  cmd = 'VenvSelect',
  keys = {
    { '<localleader>v', '<cmd>VenvSelect<cr>', ft = 'python', desc = 'Select venv' },
  },
  opts = {
    options = {
      picker = 'snacks', -- reuse snacks.picker instead of telescope
    },
    search = {},
  },
}
