return {
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      -- defined BEFORE themery.setup so the initial themery-applied
      -- colorscheme can still be synced manually below
      local function osc12(hex)
        io.write(string.format('\027]12;%s\007', hex))
      end

      local function osc112_reset()
        io.write '\027]112\007'
      end

      local function hex_from_hl(name)
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        local val = hl.bg or hl.fg
        if val then
          return string.format('#%06x', val)
        end
        return nil
      end

      local function sync_cursor_color(colorscheme_name)
        if colorscheme_name == nil or colorscheme_name == 'default' then
          osc112_reset()
          return
        end
        --local candidates = { 'Statement', 'Type', 'Special', 'Function', 'Constant', 'IncSearch', 'String', 'Identifier' }
        local hex = hex_from_hl 'Type' or hex_from_hl 'Type' or hex_from_hl 'Special'
        if hex then
          osc12(hex)
        end
      end
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          if vim.bo.buftype ~= 'terminal' then
            sync_cursor_color(vim.g.colors_name)
          end
        end,
      })
      require('themery').setup {
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
      }

      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function(ev)
          if ev.match ~= 'default' then
            vim.cmd 'syntax on'
          end
          sync_cursor_color(ev.match)
        end,
      })

      vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, {
        callback = osc112_reset,
      })

      -- cover the colorscheme themery already applied synchronously
      -- above, before the autocmd existed to catch it
      sync_cursor_color(vim.g.colors_name)

      vim.keymap.set('n', '<leader>nt', '<cmd>Themery<CR>', { desc = '[t]heme' })
    end,
  },
  {
    'https://github.com/scottmckendry/cyberdream.nvim',
    lazy = true,
    config = function()
      require('cyberdream').setup {
        transparent = true,
        styles = {
          comments = { italic = true },
        },
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    config = function()
      require('tokyonight').setup {
        transparent = true,
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
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'boring',
        callback = function()
          vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
          vim.cmd 'hi NormalNC guibg=NONE ctermbg=NONE'
          vim.cmd 'hi SignColumn guibg=NONE ctermbg=NONE'
          vim.cmd 'hi LineNr guibg=NONE ctermbg=NONE'
        end,
      })
    end,
  },
}
