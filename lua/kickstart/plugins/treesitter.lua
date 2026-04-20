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
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > 100 * 1024 then
            return
          end
          pcall(vim.treesitter.start, args.buf, lang)
        end,
      })
    end,
  },
}
