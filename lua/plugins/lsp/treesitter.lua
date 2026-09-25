local has_ts_cli = vim.fn.executable 'tree-sitter' == 1

if has_ts_cli then
  -- Full setup: `main` branch, CLI available, all parsers including latex
  return {
    {
      'nvim-treesitter/nvim-treesitter',
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
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'latex',
        }

        -- Highlight via FileType autocmd
        vim.api.nvim_create_autocmd('FileType', {
          callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match) or args.match
            if lang == 'latex' then
              return
            end
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
            if ok and stats and stats.size > 100 * 1024 then
              return
            end
            pcall(vim.treesitter.start, args.buf, lang)
          end,
        })
      end,
    },
  }
else
  -- Fallback: `master` branch, no CLI needed, latex dropped (needs CLI to regenerate)
  return {
    {
      'nvim-treesitter/nvim-treesitter',
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
          },
          indent = {
            enable = true,
          },
        }
      end,
    },
  }
end
