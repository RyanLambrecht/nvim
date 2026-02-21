-- Filetype-specific wrap behavior

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'python',
    'javascript',
    'typescript',
    'lua',
    'go',
    'rust',
    'ruby',
    'php',
  },
  callback = function()
    vim.opt_local.wrap = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
  end,
})
