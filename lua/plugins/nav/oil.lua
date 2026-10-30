local opens_dir = vim.fn.argc(-1) > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1

---@type LazySpec
return {
  {
    'stevearc/oil.nvim',
    -- lazy = false,
    lazy = not opens_dir,
    event = 'VeryLazy', -- only matters when lazy = true
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
        ['<localleader>vd'] = {
          callback = function()
            vim.cmd 'vsplit ~/Downloads/'
          end,
          desc = 'Oil: open Downloads in vsplit',
        },
        ['<C-c>'] = false,
        ['<C-h>'] = false,
        ['<C-j>'] = false,
        ['<C-k>'] = false,
        ['<C-l>'] = false,
        ['<C-x>'] = 'actions.close',
        ['<localleader>r'] = 'actions.refresh',
        ['<localleader>o'] = {
          callback = function()
            local dir = require('oil').get_current_dir()
            if not dir then
              vim.notify('Oil: no current directory', vim.log.levels.WARN)
              return
            end
            vim.fn.jobstart({ 'open', dir }, { detach = true })
          end,
          desc = 'Oil: open in Finder',
        },
        ['<localleader>Y'] = 'actions.yank_entry',
        ['<localleader>y'] = {
          callback = function()
            local dir = require('oil').get_current_dir()
            if dir then
              vim.fn.setreg('+', dir)
              vim.notify('Yanked: ' .. dir)
            end
          end,
          desc = 'Oil: yank current directory',
        },
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
  },

  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<localleader>v', group = 'vsplit' },
      },
    },
  },
}
