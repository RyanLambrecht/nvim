return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.2) -- 40% of screen width
          elseif term.direction == 'horizontal' then
            return 15
          end
        end,
        direction = 'horizontal', -- use "float" if you prefer floating terminals
        shade_terminals = true,
        start_in_insert = true, -- start terminal ready for input
        persist_mode = true, -- keeps insert mode on reopen
        close_on_exit = true,
        shell = vim.o.shell, -- use your default shell
      }

      local Terminal = require('toggleterm.terminal').Terminal

      -- one shared terminal for both ts/tv
      local term = Terminal:new { direction = 'horizontal' }

      local function toggle_direction(direction)
        if term:is_open() then
          if term.direction ~= direction then
            -- already open in the other orientation: move it
            term:close()
            term.direction = direction
            term:open()
          else
            -- already open in this orientation: toggle closed
            term:close()
          end
        else
          term.direction = direction
          term:open()
        end
      end

      vim.keymap.set('n', '<leader>ts', function()
        toggle_direction 'horizontal'
      end, { desc = 'Terminal horizontal split' })
      vim.keymap.set('n', '<leader>tv', function()
        toggle_direction 'vertical'
      end, { desc = 'Terminal vertical split' })

      -- <leader>t namespace: terminal-specific actions
      -- Keybinding: toggle terminal
      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle [t]erminal' })
      vim.keymap.set('n', '<C-/>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle [t]erminal' })

      -- opens terminal at the current dir in current buffer
      -- dir of buffer, supports oil
      vim.keymap.set('n', '<leader>tB', function()
        local ok, oil = pcall(require, 'oil')
        local dir
        if ok then
          dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
        else
          dir = vim.fn.expand '%:p:h'
        end
        vim.cmd.lcd(dir)
        vim.cmd.terminal()
      end, { desc = 'which_key_ignore' })

      vim.keymap.set('n', '<leader>tb', ':term<CR>', { desc = 'Terminal in buff' })

      vim.keymap.set('n', '<leader>tS', function()
        local ok, oil = pcall(require, 'oil')
        local dir
        if ok then
          dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
        else
          dir = vim.fn.expand '%:p:h'
        end
        Terminal:new({ dir = dir, direction = 'horizontal' }):toggle()
      end, { desc = 'which_key_ignore' })

      vim.keymap.set('n', '<leader>tV', function()
        local ok, oil = pcall(require, 'oil')
        local dir
        if ok then
          dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
        else
          dir = vim.fn.expand '%:p:h'
        end
        Terminal:new({ dir = dir, direction = 'vertical' }):toggle()
      end, { desc = 'which_key_ignore' })
    end,
  },
}

-- vim.keymap.set('n', '<leader>ts', function()
--   Terminal:new({ direction = 'horizontal' }):toggle()
-- end, { desc = 'Terminal horizontal split' })
-- vim.keymap.set('n', '<leader>tv', function()
--   Terminal:new({ direction = 'vertical' }):toggle()
-- end, { desc = 'Terminal vertical split' })
