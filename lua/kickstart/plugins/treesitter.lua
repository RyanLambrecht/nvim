return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- matches your Treesitter branch
    opts = {
      ensure_installed = { 'java', 'go', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
        disable = function(lang, buf)
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > 100 * 1024
        end,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
