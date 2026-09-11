return {
  'uga-rosa/ccc.nvim',
  event = 'VeryLazy',
  ft = { 'html', 'css', 'javascript', 'typescript' },

  config = function()
    local ccc = require 'ccc'
    local wk = require 'which-key'

    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }

    vim.keymap.set('n', '<localleader>cp', ':CccPick<CR>', {
      desc = 'Pick color',
    })

    vim.keymap.set('n', '<localleader>cc', ':CccConvert<CR>', {
      desc = 'Convert color',
    })

    wk.add {
      { '<localleader>c', group = 'Color' },
    }
  end,
}
