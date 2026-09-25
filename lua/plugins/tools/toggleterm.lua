local term = nil

local function get_term()
  if not term then
    local Terminal = require('toggleterm.terminal').Terminal
    term = Terminal:new { direction = 'horizontal' }
  end
  return term
end

-- shared terminal for both ts/tv
local function toggle_direction(direction)
  local t = get_term()
  if t:is_open() then
    if t.direction ~= direction then
      -- already open in the other orientation: move it
      t:close()
      t.direction = direction
      t:open()
    else
      -- already open in this orientation: toggle closed
      t:close()
    end
  else
    t.direction = direction
    t:open()
  end
end

-- opens a fresh terminal scoped to current dir (supports oil)
local function scoped_terminal(direction)
  local Terminal = require('toggleterm.terminal').Terminal
  local ok, oil = pcall(require, 'oil')
  local dir
  if ok then
    dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
  else
    dir = vim.fn.expand '%:p:h'
  end
  Terminal:new({ dir = dir, direction = direction }):toggle()
end

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      {
        '<leader>ts',
        function()
          toggle_direction 'horizontal'
        end,
        desc = 'Terminal horizontal split',
      },
      {
        '<leader>tv',
        function()
          toggle_direction 'vertical'
        end,
        desc = 'Terminal vertical split',
      },
      -- <leader>t namespace: terminal-specific actions
      -- Keybinding: toggle terminal
      { '<leader>tt', '<cmd>ToggleTerm<CR>', desc = 'Toggle [t]erminal' },
      { '<C-/>', '<cmd>ToggleTerm<CR>', desc = 'Toggle [t]erminal' },

      -- opens terminal at the current dir in current buffer
      -- dir of buffer, supports oil
      {
        '<leader>tB',
        function()
          local ok, oil = pcall(require, 'oil')
          local dir
          if ok then
            dir = oil.get_current_dir() or vim.fn.expand '%:p:h'
          else
            dir = vim.fn.expand '%:p:h'
          end
          vim.cmd.lcd(dir)
          vim.cmd.terminal()
        end,
        desc = 'which_key_ignore',
      },

      { '<leader>tb', ':term<CR>', desc = 'Terminal in buff' },

      {
        '<leader>tS',
        function()
          scoped_terminal 'horizontal'
        end,
        desc = 'which_key_ignore',
      },
      {
        '<leader>tV',
        function()
          scoped_terminal 'vertical'
        end,
        desc = 'which_key_ignore',
      },
    },
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
    end,
  },
}

-- vim.keymap.set('n', '<leader>ts', function()
--   Terminal:new({ direction = 'horizontal' }):toggle()
-- end, { desc = 'Terminal horizontal split' })
-- vim.keymap.set('n', '<leader>tv', function()
--   Terminal:new({ direction = 'vertical' }):toggle()
-- end, { desc = 'Terminal vertical split' })
