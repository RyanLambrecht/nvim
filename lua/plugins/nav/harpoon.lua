---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',

  keys = function()
    local function list()
      return require('harpoon'):list()
    end

    return {
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
        '<leader>jc',
        function()
          list():clear()
        end,
        desc = 'Harpoon: clear all files',
      },
      {
        '<leader>jj',
        function()
          require('harpoon').ui:toggle_quick_menu(list())
        end,
        desc = 'Harpoon: menu',
      },

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

      {
        '<leader>sj',
        function()
          local files = {}

          for _, item in ipairs(list().items) do
            table.insert(files, {
              text = item.value,
              file = item.value,
            })
          end

          Snacks.picker {
            items = files,
            format = 'file',
            title = 'Harpoon',
          }
        end,
        desc = '[s]earch Harpoon files',
      },
    }
  end,

  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
