---@type LazySpec
return {
  {
    'jbyuki/nabla.nvim',
    ft = { 'markdown', 'tex' },
    keys = {
      {
        '<localleader><localleader>',
        function()
          require('nabla').popup()
        end,
        desc = 'Nabla: popup equation preview',
      },
      {
        '<localleader>Tn',
        function()
          require('nabla').toggle_virt()
        end,
        ft = { 'markdown', 'tex' },
        desc = 'Nabla: toggle inline virtual text',
      },
      -- optional
      -- {
      --   'K',
      --   function()
      --     require('nabla').popup()
      --   end,
      --   ft = { 'markdown', 'tex' },
      --   desc = 'Nabla: popup equation preview',
      -- },
    },
  },
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<localleader>T', group = 'Toggle' },
      },
    },
  },
}
