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

      local enabled = true

      vim.api.nvim_create_user_command('WhichKeyToggle', function()
        if enabled then
          wk.disable()
          vim.notify('which-key disabled', vim.log.levels.INFO)
        else
          wk.enable()
          vim.notify('which-key enabled', vim.log.levels.INFO)
        end
        enabled = not enabled
      end, { desc = 'Toggle which-key' })

      vim.keymap.set('n', '<leader>Tw', '<cmd>WhichKeyToggle<cr>', { desc = '[T]oggle [W]hich-Key' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
