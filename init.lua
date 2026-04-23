if vim.fn.getcwd() == '~' or vim.fn.getcwd() == vim.env.HOME then
  vim.cmd.cd(vim.fn.expand '~')
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.have_nerd_font = true

require 'options'

require 'keymaps'

require 'lazy-bootstrap'
require 'lazy-plugins'
require 'autocmd'

-- experimental ui

require('vim._core.ui2').enable {}
--:help modeline if need
