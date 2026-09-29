vim.loader.enable()

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

-- custom
require('custom.cursorline').setup()
require('custom.dynamic-theme').apply_saved_theme()

-- experimental ui

require('vim._core.ui2').enable {}
-- --:help modeline if need
