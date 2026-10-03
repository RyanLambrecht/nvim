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

---------------------------------------------------------------------------
-- Terminal management: cycle / pick / delete
---------------------------------------------------------------------------

local function terms()
  return require('toggleterm.terminal').get_all(true) -- sorted by id
end

-- the toggleterm terminal in the focused window, if any
local function current_term()
  local buf = vim.api.nvim_get_current_buf()
  for _, t in ipairs(terms()) do
    if t.bufnr == buf then
      return t
    end
  end
end

-- close the focused terminal (if any) and open `target` in its place
local function switch_to(target)
  local cur = current_term()
  if cur == target then
    return
  end
  if cur then
    cur:close()
  end
  target:open()
end

local function cycle(step)
  local all = terms()
  if #all == 0 then
    return vim.notify('No terminals', vim.log.levels.INFO)
  end
  local cur, idx = current_term(), 0
  for i, t in ipairs(all) do
    if t == cur then
      idx = i
    end
  end
  local target
  if idx == 0 then
    target = step > 0 and all[1] or all[#all]
  else
    target = all[((idx - 1 + step) % #all) + 1]
  end
  switch_to(target)
end

local function kill(t)
  if t == term then
    term = nil -- shared terminal gets recreated on next <leader>ts/tv
  end
  t:shutdown() -- closes window, kills job, wipes buffer
end

local function label(t)
  local dir = t.dir and vim.fn.fnamemodify(t.dir, ':~') or vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  return string.format('%d  %-10s %s%s', t.id, t.direction, dir, t:is_open() and '  ●' or '')
end

local function pick(prompt, on_choice)
  local all = terms()
  if #all == 0 then
    return vim.notify('No terminals', vim.log.levels.INFO)
  end
  vim.ui.select(all, { prompt = prompt, format_item = label }, function(t)
    if t then
      on_choice(t)
    end
  end)
end

local function delete_current()
  local cur = current_term()
  if not cur then
    return vim.notify('Not in a toggleterm terminal', vim.log.levels.WARN)
  end
  local all = terms()
  local fallback
  for i, t in ipairs(all) do
    if t == cur then
      fallback = all[i - 1] or all[i + 1]
    end
  end
  kill(cur)
  if fallback then
    fallback:open()
  end
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
      { '<C-_>', '<cmd>ToggleTerm<CR>', desc = 'which_key_ignore' }, -- just to support tmux, idk why it work tbh
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

      -- terminal management
      {
        '<leader>tn',
        function()
          cycle(1)
        end,
        desc = 'Next terminal',
      },
      {
        '<leader>tp',
        function()
          cycle(-1)
        end,
        desc = 'Previous terminal',
      },
      {
        '<leader>tl',
        function()
          pick('Switch terminal', switch_to)
        end,
        desc = 'List/switch terminals',
      },
      { '<leader>td', delete_current, desc = 'Delete current terminal' },
      {
        '<leader>tx',
        function()
          pick('Delete terminal', kill)
        end,
        desc = 'Pick terminal to delete',
      },
      {
        '<leader>tX',
        function()
          for _, t in ipairs(terms()) do
            kill(t)
          end
        end,
        desc = 'Delete all terminals',
      },
    },
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.2) -- 20% of screen width
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
