-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- UI
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 10
vim.o.inccommand = 'split'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Tabs / Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Files
vim.o.undofile = true
vim.o.confirm = true

-- Clipboard (scheduled to avoid startup delay)
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Mouse
vim.o.mouse = ''

-- Folding
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()' -- see note: may need v:lua.vim.treesitter.foldexpr()
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- Tabline (without close button)
vim.o.showtabline = 1
vim.o.tabline = '%!v:lua.NoCloseTabline()'

function _G.NoCloseTabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr '$' do
    local hl = i == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
    local bufname = vim.fn.bufname(vim.fn.tabpagebuflist(i)[1])
    s = s .. '%' .. i .. 'T' .. hl .. ' ' .. bufname .. ' '
  end
  return s .. '%#TabLineFill#'
end

-- venv for python
vim.g.python3_host_prog = vim.fn.expand '~/.venvs/nvim/bin/python3'

-- :grep uses ripgrep
vim.o.grepprg = 'rg --vimgrep --smart-case'

vim.filetype.add { extension = { tmpl = 'gohtmltmpl' } }
