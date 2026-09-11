-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  lazy = true,
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '\\',
      function()
        if vim.bo.filetype == 'oil' then
          vim.cmd 'Neotree show'
        else
          vim.cmd 'Neotree reveal'
        end
      end,
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'disabled',
      window = {
        width = 25,
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
