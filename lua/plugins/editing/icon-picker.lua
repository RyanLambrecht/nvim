---@type LazySpec
return {
  'ziontee113/icon-picker.nvim',
  ft = { 'markdown', 'text' },
keys = {
  { '<leader><localleader>i', '<cmd>IconPickerNormal<cr>', mode = 'n', ft = 'markdown' },
  { '<C-,>', '<Esc><cmd>IconPickerYank<cr>', mode = 'i', ft = 'markdown' },
  { '<leader><localleader>,', 'pa', mode = 'n', ft = 'markdown' },
},
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }
  end,
}
