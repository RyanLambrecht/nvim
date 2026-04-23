require('lazy').setup({
  { import = 'plugins.ui' },
  { import = 'plugins.lsp' },
  { import = 'plugins.misc' },
  { import = 'plugins.editing' },
  { import = 'plugins.lang' },
  { import = 'plugins.nav' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
