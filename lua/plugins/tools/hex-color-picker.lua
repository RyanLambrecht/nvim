---@type LazySpec
return {
  {
    'uga-rosa/ccc.nvim',
    ft = { 'html', 'css', 'javascript', 'typescript' },
    keys = {
      { '<leader><localleader>cp', '<cmd>CccPick<cr>', desc = 'Pick color' },
      { '<leader><localleader>cc', '<cmd>CccConvert<cr>', desc = 'Convert color' },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },

  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>c', group = 'Color' },
      },
    },
  },
}
