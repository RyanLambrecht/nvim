return {

  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
    },

    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },

    win_options = {
      wrap = true,
      winblend = 0,
    },

    keymaps = {
      ['<C-c>'] = false,
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
      ['q'] = 'actions.close',
    },
  },

  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<space>-', require('oil').toggle_float)
  end,
}
