return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    require('harpoon'):setup()
  end,

  keys = function()
    local harpoon = require 'harpoon'

    local function list()
      return harpoon:list()
    end

    return {
      -- core actions
      {
        '<leader>ja',
        function()
          list():add()
        end,
        desc = 'Harpoon: add file',
      },
      {
        '<leader>jd',
        function()
          list():remove()
        end,
        desc = 'Harpoon: remove file',
      },
      {
        '<leader>jj',
        function()
          harpoon.ui:toggle_quick_menu(list())
        end,
        desc = 'Harpoon: menu',
      },

      -- direct navigation
      {
        '<leader>j1',
        function()
          list():select(1)
        end,
        desc = 'Harpoon: file 1',
      },
      {
        '<leader>j2',
        function()
          list():select(2)
        end,
        desc = 'Harpoon: file 2',
      },
      {
        '<leader>j3',
        function()
          list():select(3)
        end,
        desc = 'Harpoon: file 3',
      },
      {
        '<leader>j4',
        function()
          list():select(4)
        end,
        desc = 'Harpoon: file 4',
      },

      -- sequential navigation
      {
        '<C-n>',
        function()
          list():next()
        end,
        desc = 'Harpoon: next file',
      },
      {
        '<C-p>',
        function()
          list():prev()
        end,
        desc = 'Harpoon: prev file',
      },

      -- telescope integration
      {
        '<leader>sj',
        function()
          local conf = require('telescope.config').values

          local files = {}
          for _, item in ipairs(list().items) do
            table.insert(files, item.value)
          end

          require('telescope.pickers')
            .new({}, {
              prompt_title = 'Harpoon',
              finder = require('telescope.finders').new_table {
                results = files,
              },
              previewer = conf.file_previewer {},
              sorter = conf.generic_sorter {},
            })
            :find()
        end,
        desc = '[s]earch Harpoon files',
      },
    }
  end,
}
