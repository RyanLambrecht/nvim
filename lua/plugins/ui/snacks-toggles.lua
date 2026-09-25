-- lua/plugins/ui/snacks-toggles.lua
return {
  'folke/snacks.nvim',

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>Ts'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>Tw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>TL'
        Snacks.toggle.line_number():map '<leader>Tl'
        Snacks.toggle.diagnostics():map '<leader>Td'
        Snacks.toggle.inlay_hints():map '<leader>Th'
        Snacks.toggle.treesitter():map '<leader>TT'
        Snacks.toggle
          .option('colorcolumn', {
            name = 'Colorcolumn',
            off = '',
            on = '80',
          })
          :map '<leader>Tc'
      end,
    })
  end,
}
