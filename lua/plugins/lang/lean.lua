return {
  {
    'Julian/lean.nvim',
    ft = { 'lean' },

    dependencies = {
      'nvim-telescope/telescope.nvim',
    },

    init = function()
      vim.g.lean_config = {
        mappings = true,

        infoview = {
          autoopen = true,
        },

        graphics = {
          enabled = true,
        },
      }
    end,
  },
}
