--[[
    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html
--]]
if vim.fn.getcwd() == '~' or vim.fn.getcwd() == vim.env.HOME then
  vim.cmd.cd(vim.fn.expand '~')
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'
--changes ~ to be $HOME(which is the same as ~ in shell)
--if vim.fn.empty(vim.env.HOME) == 1 then
--  vim.env.HOME = vim.fn.expand '~'
--end

-- The line beneath this is called `modeline`. See `:help modeline`
