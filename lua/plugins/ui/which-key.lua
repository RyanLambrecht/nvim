return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>j', group = 'harpoon [j]ump' },
        { '<leader>T', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP-[r]elated group' },
        { '<leader>m', group = 'music' },
        { '<leader>t', group = '[t]erminal' },
        { '<leader>n', group = '[n]eovim' },
        { '<leader>ms', group = '[s]earch' },
        { '<leader>ns', group = '[s]ession' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)

      -- which-key has no enable()/disable() API, but it reads `delay` from its
      -- config every time it schedules the popup. Pushing the delay out of reach
      -- keeps the popup from ever appearing (mappings still work normally),
      -- and restoring the original delay brings it back.
      local wk_config = require 'which-key.config'
      local original_delay = opts.delay
      local never = 2147483647 -- ms (~24 days)

      -- Persistence: shada saves global variables that are ALL UPPERCASE
      -- (requires '!' in 'shada', which is in Neovim's default). It's written on
      -- exit and read before VimEnter, so it's available here. nil means "never
      -- toggled", which counts as enabled.
      local function is_enabled()
        return vim.g.WHICH_KEY_ENABLED ~= false
      end

      local function apply(state)
        wk_config.options.delay = state and original_delay or never
      end

      apply(is_enabled())

      local toggle = Snacks.toggle.new {
        id = 'which_key',
        name = 'Which-Key',
        get = is_enabled,
        set = function(state)
          vim.g.WHICH_KEY_ENABLED = state
          apply(state)
        end,
      }

      toggle:map '<leader>Tw'

      -- optional: keep the command around
      vim.api.nvim_create_user_command('WhichKeyToggle', function()
        toggle:toggle()
      end, { desc = 'Toggle which-key' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
