---@type LazySpec
return {
  'RyanLambrecht/NeoColumn.nvim',
  branch = 'my-patch',
  event = 'BufReadPost',
  opts = {
    NeoColumn = '75',
    always_on = true,
  },
}
