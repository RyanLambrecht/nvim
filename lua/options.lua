-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- UI
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 10
vim.o.inccommand = 'split'
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}
vim.o.termguicolors = true

--vim.o.colorcolumn = '80'
vim.o.inccommand = 'split'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.termguicolors = true
-- vim.api.nvim_set_hl(0, 'Cursor', { fg = '#000000', bg = '#FF0000' })

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Tabs / Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Performance
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
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
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
