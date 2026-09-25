-- snacks-picker.lua
return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    picker = {
      preview = false,
      layout = {},
    },
  },

  keys = {
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sF',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker()
      end,
      desc = '[S]earch [S]elect Picker',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[ ] Find existing buffers',
    },

    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = '[/] Fuzzily search in current buffer',
    },

    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },

    {
      '<leader>sC',
      function()
        Snacks.picker.files {
          cwd = vim.fn.stdpath 'config',
        }
      end,
      desc = '[S]earch neovim [C]onfig files',
    },

    {
      '<leader>sN',
      function()
        Snacks.picker.files {
          cwd = '~/notes/',
        }
      end,
      desc = '[S]earch [N]otes files',
    },

    {
      '<leader>sn',
      function()
        Snacks.picker.files {
          cwd = '~/notes/',
          finder = 'files',
          args = { '--type', 'd' },
          title = 'Search note directories',
        }
      end,
      desc = '[S]earch [n]ote directories',
    },

    {
      '<leader>sP',
      function()
        Snacks.picker.files {
          cwd = '~/code/',
          finder = 'files',
          args = { '--type', 'd' },
          title = 'Search Projects',
        }
      end,
      desc = '[S]earch [P]roject files',
    },

    {
      '<leader>sv',
      function()
        Snacks.picker.files {
          cwd = '~/dev/',
          finder = 'files',
          args = { '--type', 'd', '--max-depth', '2', '--min-depth', '1' },
          title = 'Search Projects',
          preview = false,
        }
      end,
      desc = '[S]earch de[v] directories',
    },

    {
      '<leader>sp',
      function()
        Snacks.picker.files {
          cwd = '~/code/',
          finder = 'files',
          args = { '--type', 'd', '--max-depth', '2', '--min-depth', '2' },
          title = 'Search Projects',
          preview = false,
        }
      end,
      desc = '[S]earch [p]roject directories',
    },

    {
      '<leader>sd',
      function()
        Snacks.picker.files {
          finder = 'files',
          args = { '--type', 'd' },
          preview = false,
        }
      end,
      desc = '[S]earch [d]irectories',
    },

    {
      '<leader>so',
      function()
        Snacks.picker.options()
      end,
      desc = '[o]ptions',
    },
    {
      '<leader>st',
      function()
        local cache = vim.fn.stdpath 'cache' .. '/tmux-manpage.txt'
        if vim.fn.filereadable(cache) == 0 then
          vim.fn.system('MANWIDTH=100 man tmux | col -bx > ' .. cache)
        end
        Snacks.picker.grep {
          dirs = { vim.fn.stdpath 'cache' },
          glob = 'tmux-manpage.txt',
          title = 'Tmux Docs',
          layout = { preset = 'ivy' },
        }
      end,
      desc = 'Search Tmux docs',
    },
  },
}
