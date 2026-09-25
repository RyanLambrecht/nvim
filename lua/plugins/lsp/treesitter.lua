return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = function()
      if vim.fn.executable 'tree-sitter' == 1 then
        vim.cmd 'TSUpdate'
      end
    end,
    config = function()
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/nvim-treesitter',
      }

      if vim.fn.executable 'tree-sitter' == 1 then
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
      else
        vim.notify('tree-sitter CLI not found, skipping parser install', vim.log.levels.WARN)
      end

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
