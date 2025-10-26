return {
  {
    'fatih/vim-go',
    build = ':GoInstallBinaries',
    config = function()
      vim.g.go_diagnostics_enabled = 0
      vim.g.go_metalinter_enabled = {}
      vim.g.go_jump_to_error = 0
      vim.g.go_fmt_command = 'goimports'
      vim.g.go_auto_sameids = 0
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_generate_tags = 1
    end,
  },
}
