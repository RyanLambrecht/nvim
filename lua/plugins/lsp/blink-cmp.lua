---@type LazySpec
return {
  { -- Autocompletion
    'saghen/blink.cmp',
    lazy = true,
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '1.*',
        lazy = true,
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        --documentation = { auto_show = true, auto_show_delay_ms = 500 },
        --    ghost_text = { enabled = true },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets' }, --'copilot'
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
          -- word completion from the current buffer for notes
          --markdown = { inherit_defaults = true, 'buffer' },
          --text = { inherit_defaults = true, 'buffer' },
        },
        providers = {
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
          lsp = { score_offset = 0 },
          path = { score_offset = 3 },
          snippets = { score_offset = -3 },
          buffer = { score_offset = -10 },
          -- copilot = {
          --   name = 'copilot',
          --   module = 'blink-copilot',
          --   score_offset = 100,
          --   async = true,
          -- },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes a rust fuzzy matcher (faster and typo resistant).
      -- With `version = '1.*'` above, lazy.nvim checks out a release tag, so a
      -- prebuilt binary is downloaded automatically.
      --
      -- 'prefer_rust_with_warning' falls back to the Lua implementation and
      -- warns if the binary is unavailable. Use 'lua' to force the Lua one.
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = {
        enabled = true,
        trigger = { show_on_accept = true }, -- pops up right after accepting a completion
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
