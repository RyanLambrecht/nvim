return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'horizontal', -- use "float" if you prefer floating terminals
        shade_terminals = true,
        start_in_insert = true, -- start terminal ready for input
        persist_mode = true, -- keeps insert mode on reopen
        close_on_exit = true,
        shell = vim.o.shell, -- use your default shell
      }
    end,
  },
}
