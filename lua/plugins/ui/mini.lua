return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Sessions: save and restore your open files, splits, and cursor positions
      --
      -- First time on a project:  <leader>nsw  then type a name (e.g. "myproject")
      -- Coming back to a project: <leader>nsl  and pick it from the list
      -- Cleanup old sessions:     <leader>nsd  and pick one to delete
      -- Detach (don't save on exit): <leader>nsx
      --
      -- autowrite means quitting Neovim automatically updates the current session,
      -- so you only ever need <leader>nswonce per project.
      require('mini.sessions').setup {
        autowrite = true,
        directory = vim.fn.stdpath 'data' .. '/sessions',
      }
      vim.keymap.set('n', '<leader>nsw', function()
        MiniSessions.write(vim.fn.input 'Session name: ')
      end, { desc = '[s]ession [w]rite' })
      vim.keymap.set('n', '<leader>nsl', function()
        MiniSessions.select()
      end, { desc = '[s]ession [l]oad' })
      vim.keymap.set('n', '<leader>nsd', function()
        MiniSessions.select 'delete'
      end, { desc = '[s]ession [d]elete' })
      vim.keymap.set('n', '<leader>nsx', function()
        vim.v.this_session = ''
        vim.notify('Session detached', vim.log.levels.INFO)
      end, { desc = '[s]ession [x] detach' })

      -- Open the snacks dashboard from anywhere
      vim.keymap.set('n', '<leader>nd', function()
        require('snacks').dashboard()
      end, { desc = '[d]ashboard' })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
