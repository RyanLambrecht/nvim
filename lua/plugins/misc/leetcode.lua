return {
  'kawre/leetcode.nvim',
  cmd = 'Leet',
  build = ':TSUpdate html',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function(_, opts)
    -- Keymaps are only registered after the plugin loads (i.e. after :Leet)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      once = true,
      callback = function(event)
        if event.data == 'leetcode.nvim' then
          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
          end
          map('<leader>ll', '<cmd>Leet list<cr>', 'List problems')
          map('<leader>ld', '<cmd>Leet daily<cr>', 'Daily challenge')
          map('<leader>lt', '<cmd>Leet tabs<cr>', 'Open tabs')
          map('<leader>lr', '<cmd>Leet run<cr>', 'Run code')
          map('<leader>ls', '<cmd>Leet submit<cr>', 'Submit solution')
          map('<leader>lx', '<cmd>Leet reset<cr>', 'Reset code')
          map('<leader>lL', '<cmd>Leet last_submit<cr>', 'Load last submit')
          map('<leader>lb', '<cmd>Leet open<cr>', 'Open in browser')
          map('<leader>li', '<cmd>Leet info<cr>', 'Problem info')
          map('<leader>lc', '<cmd>Leet console<cr>', 'Toggle console')
          map('<leader>lm', '<cmd>Leet menu<cr>', 'Open menu')
        end
      end,
    })

    require('leetcode').setup(opts)
  end,
  opts = {
    non_standalone = true,
    lang = 'golang',
    injector = {
      ['golang'] = {
        before = 'package main',
      },
    },
    description = {
      position = 'right',
      width = '40%',
    },
  },
}
