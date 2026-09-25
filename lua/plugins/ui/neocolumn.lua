return {
  'ecthelionvi/NeoColumn.nvim',
  lazy = true,
  build = function(plugin)
    local patch = vim.fn.stdpath 'config' .. '/patches/NeoColumn.nvim.patch'
    if vim.fn.system {
      'git',
      '-C',
      plugin.dir,
      'apply',
      '--check',
      patch,
    } == 0 then
      vim.fn.system {
        'git',
        '-C',
        plugin.dir,
        'apply',
        patch,
      }
    end
  end,

  opts = {},
}
