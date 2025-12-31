-- File: vim_c_learning_setup.lua
-- Place this in your Neovim 'plugins' folder for lazy loading with your plugin manager (e.g., 'lazy.nvim')

return {
  -- Tag management (ctags) for code navigation
  {
    'ludovicchabant/vim-gutentags',
    lazy = true,
    config = function()
      vim.g.gutentags_project_root = { './', '.git', 'Makefile' }
      vim.g.gutentags_ctags_tagfile = 'tags'
    end,
  },

  -- Async linting engine (ALE) for catching C errors
  {
    'dense-analysis/ale',
    lazy = true,
    config = function()
      vim.g.ale_linters_explicit = 1
      vim.g.ale_fix_on_save = 0
      vim.g.ale_fixers = { c = { 'clang-format' } }
    end,
  },

  -- File browsing (optional, lightweight)
  {
    'preservim/nerdtree',
    lazy = true,
    cmd = { 'NERDTreeToggle', 'NERDTreeFind' },
  },

  -- Quick file switching/searching
  {
    'junegunn/fzf',
    lazy = true,
    run = './install --all',
  },

  -- Header/source switching for C
  {
    'pchynoweth/a.vim',
    lazy = true,
  },

  -- Ergonomic editing: surrounding brackets/quotes/etc.
  {
    'tpope/vim-surround',
    lazy = true,
  },
}
