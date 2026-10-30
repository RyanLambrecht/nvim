-- Go HTML templates: detected as `gohtmltmpl`, parsed with the gotmpl grammar.
-- Kept at the top so it runs before any FileType autocmd looks up the parser.
vim.treesitter.language.register('gotmpl', 'gohtmltmpl')

local has_ts_cli = vim.fn.executable 'tree-sitter' == 1

if has_ts_cli then
  -- Full setup: `main` branch, CLI available
  return {
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false, -- main branch doesn't support lazy-loading; ensures the FileType autocmd exists before the first buffer
      branch = 'main',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter').setup {
          install_dir = vim.fn.stdpath 'data' .. '/nvim-treesitter',
        }

        require('nvim-treesitter').install {
          'python',
          'java',
          'go',
          'bash',
          'c',
          'cpp',
          'diff',
          'html',
          'css',
          'templ',
          'gotmpl',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'latex', -- installed for other plugins; highlighting is skipped below so vimtex syntax stays
          'typescript',
          'javascript',
        }

        vim.api.nvim_create_autocmd('FileType', {
          callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match) or args.match

            -- vimtex provides its own syntax/conceal
            if lang == 'latex' then
              return
            end

            -- skip large files
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
            if ok and stats and stats.size > 100 * 1024 then
              return
            end

            if pcall(vim.treesitter.start, args.buf, lang) then
              -- Optional (experimental) treesitter indent; uncomment to match the master fallback:
              -- vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end,
        })
      end,
    },
  }
else
  -- Fallback: `master` branch, no CLI needed, latex dropped
  return {
    {
      'nvim-treesitter/nvim-treesitter',
      event = { 'BufReadPost', 'BufNewFile' },
      branch = 'master',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'python',
            'java',
            'go',
            'bash',
            'c',
            'cpp',
            'diff',
            'html',
            'css',
            'templ',
            'gotmpl',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
            -- 'latex', -- needs tree-sitter CLI to regenerate; unavailable here
          },
          auto_install = false,
          highlight = {
            enable = true,
            disable = { 'latex' }, -- keep vimtex syntax even if the parser gets installed manually
          },
          indent = {
            enable = true,
            disable = { 'latex' },
          },
        }
      end,
    },
  }
end
