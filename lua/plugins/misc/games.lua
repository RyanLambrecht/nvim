return {
  { 'alanfortlink/blackjack.nvim', cmd = 'BlackJackNewGame' },
  { 'seandewar/killersheep.nvim', cmd = 'KillKillKill' },
  { 'seandewar/nvimesweeper', cmd = 'Nvimesweeper' },
  { 'zyedidia/vim-snake', cmd = 'Snake' },
  { 'jim-fx/sudoku.nvim', cmd = 'Sudoku' },
  { 'alec-gibson/nvim-tetris', cmd = 'Tetris' },
  { 'efueyo/td.nvim', cmd = 'TdStart' },
  {
    'nvim-telescope/telescope.nvim',
    optional = true,
    cmd = 'Games',
    config = function()
      vim.api.nvim_create_user_command('Games', function()
        local games = {
          { name = 'BlackJack', cmd = 'BlackJackNewGame' },
          { name = 'KillerSheep', cmd = 'KillKillKill' },
          { name = 'Minesweeper', cmd = 'Nvimesweeper' },
          { name = 'Snake', cmd = 'Snake' },
          { name = 'Sudoku', cmd = 'Sudoku' },
          { name = 'Tetris', cmd = 'Tetris' },
          { name = 'Tower Defense', cmd = 'TdStart' },
        }

        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        pickers
          .new({}, {
            prompt_title = '🎮 Games',
            finder = finders.new_table {
              results = games,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.name,
                  ordinal = entry.name,
                }
              end,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd(selection.value.cmd)
              end)
              return true
            end,
          })
          :find()
      end, {})
    end,
  },
}
