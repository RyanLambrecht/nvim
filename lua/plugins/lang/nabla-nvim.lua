return {
  'jbyuki/nabla.nvim',
  lazy = true,
  ft = { 'markdown', 'tex' },
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'tex' },
      callback = function()
        vim.keymap.set('n', 'K', require('nabla').popup, { desc = 'Nabla: popup equation preview', buffer = true })
        vim.keymap.set('n', '<localleader>m', require('nabla').popup, { desc = 'Nabla: popup equation preview', buffer = true })
        vim.keymap.set('n', '<localLeader>tp', require('nabla').toggle_virt, { desc = 'Nabla: toggle inline virtual text', buffer = true })
      end,
    })
  end,
}
