---@type LazySpec
return {
  {
    'zaldih/themery.nvim',
    lazy = true,
    cmd = 'Themery',
    keys = {
      { '<leader>nt', '<cmd>Themery<CR>', desc = '[t]heme' },
    },
    opts = {
      themes = {
        {
          name = 'none',
          colorscheme = 'default',
          before = [[ vim.cmd('hi clear') ]],
        },
        {
          name = 'minimal',
          colorscheme = 'komau',
          after = [[
  vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')
  vim.cmd('hi SignColumn guibg=NONE ctermbg=NONE')
  vim.cmd('hi LineNr guibg=NONE ctermbg=NONE')
]],
        },
        -- {
        --   name = 'no syntax',
        --   colorscheme = 'boring',
        --   after = [[ vim.cmd('hi Normal guibg=NONE ctermbg=NONE') ]],
        -- },
        {
          name = 'cyberdream',
          colorscheme = 'cyberdream',
        },
        {
          name = 'tokyo-night-night',
          colorscheme = 'tokyonight',
        },
      },
      livePreview = true,
    },
  },
  {
    'https://github.com/scottmckendry/cyberdream.nvim',
    lazy = true,
    config = function()
      require('cyberdream').setup {
        transparent = true,
        cache = false,
        italic_comments = true,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    config = function()
      require('tokyonight').setup {
        transparent = true,
        cache = true,
      }
    end,
  },
  {
    't184256/vim-boring',
    lazy = true,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'boring',
        callback = function()
          vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
        end,
      })
    end,
  },
  {
    'ntk148v/komau.vim',
    lazy = true,
  },
}
