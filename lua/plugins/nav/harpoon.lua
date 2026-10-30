---@type LazySpec

local function list()
  return require('harpoon'):list()
end

local keys = {
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
        table.insert(files, { text = item.value, file = item.value })
      end
      Snacks.picker { items = files, format = 'file', title = 'Harpoon' }
    end,
    desc = '[s]earch Harpoon files',
  },
}

for i = 1, 4 do
  table.insert(keys, {
    '<leader>j' .. i,
    function()
      list():select(i)
    end,
    desc = 'Harpoon: file ' .. i,
  })
end

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = keys,
    config = function()
      require('harpoon'):setup() -- colon call, so no `opts`
    end,
  },

  -- Only applies if which-key is enabled elsewhere
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>j', group = 'Harpoon' },
      },
    },
  },
}
