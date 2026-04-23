return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'horizontal', -- use "float" if you prefer floating terminals
        shade_terminals = true,
        start_in_insert = true, -- start terminal ready for input
        persist_mode = true, -- keeps insert mode on reopen
        close_on_exit = true,
        shell = vim.o.shell, -- use your default shell
      }

      local Terminal = require('toggleterm.terminal').Terminal

      -- <leader>t namespace: terminal-specific actions
      -- Keybinding: toggle terminal
      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle [t]erminal' })

      -- dir of buffer, supports oil
      vim.keymap.set('n', '<leader>th', function()
        local ok, oil = pcall(require, 'oil')
        local dir
        if ok then
          dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
        else
          dir = vim.fn.expand '%:p:h'
        end
        Terminal:new({ dir = dir, direction = 'horizontal' }):toggle()
      end, { desc = 'Terminal here' })

      vim.keymap.set('n', '<leader>ts', function()
        Terminal:new({ direction = 'horizontal' }):toggle()
      end, { desc = 'Terminal horizontal split' })

      vim.keymap.set('n', '<leader>tv', function()
        Terminal:new({ direction = 'vertical' }):toggle()
      end, { desc = 'Terminal vertical split' })
    end,
  },
}
