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
      ['<localleader>r'] = 'actions.refresh',
      ['<localleader>y'] = 'actions.yank_entry',
      ['<localleader>t'] = {
        callback = function()
          local oil = require 'oil'
          local Terminal = require('toggleterm.terminal').Terminal
          local dir = oil.get_current_dir()
          if not dir then
            vim.notify('Oil: no current directory', vim.log.levels.WARN)
            return
          end
          Terminal:new({
            cmd = 'cd ' .. vim.fn.shellescape(dir) .. ' && $SHELL',
            direction = 'horizontal',
            close_on_exit = false,
          }):toggle()
        end,
        desc = 'Oil: open terminal in current dir',
      },
    },
  },
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
}
