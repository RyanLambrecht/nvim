return {
  'ziontee113/icon-picker.nvim',
  ft = { 'markdown', 'text' },
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }

    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<localleader>i', '<cmd>IconPickerNormal<cr>', opts)
    -- vim.keymap.set('n', '<localleader>y', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
    -- vim.keymap.set('i', '<C-,>', '<cmd>IconPickerInsert<cr>', opts)
    vim.keymap.set('i', '<C-,>', '<Esc><cmd>IconPickerYank<cr>', opts)
    vim.keymap.set('n', '<localleader>,', 'pa', opts)
  end,
}
