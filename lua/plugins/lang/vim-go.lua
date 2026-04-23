return {
  {
    'fatih/vim-go',
    build = ':GoInstallBinaries',
    config = function()
      vim.g.go_diagnostics_enabled = 0
      vim.g.go_metalinter_enabled = {}
      vim.g.go_jump_to_error = 0
      vim.g.go_fmt_command = 'goimports' -- formats & auto-adds imports on save
      vim.g.go_auto_sameids = 0
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_generate_tags = 1

      -- Use gopls for completion and definition lookups
      vim.g.go_def_mode = 'gopls'
      vim.g.go_info_mode = 'gopls'

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'go',
        callback = function(ev)
          local opts = function(desc)
            return { buffer = ev.buf, desc = desc }
          end

          -- run & build
          vim.keymap.set('n', '<localleader>r', '<cmd>GoRun<cr>', opts 'Go: Run')
          vim.keymap.set('n', '<localleader>b', '<cmd>GoBuild<cr>', opts 'Go: Build')

          -- test
          vim.keymap.set('n', '<localleader>t', '<cmd>GoTest<cr>', opts 'Go: Test')
          vim.keymap.set('n', '<localleader>T', '<cmd>GoTestFunc<cr>', opts 'Go: Test func')
          vim.keymap.set('n', '<localleader>c', '<cmd>GoCoverageToggle<cr>', opts 'Go: Coverage toggle')

          -- code gen / refactor
          vim.keymap.set('n', '<localleader>e', '<cmd>GoIfErr<cr>', opts 'Go: If err')
          vim.keymap.set('n', '<localleader>f', '<cmd>GoFillStruct<cr>', opts 'Go: Fill struct')
          vim.keymap.set('n', '<localleader>i', '<cmd>GoImpl<cr>', opts 'Go: Implement interface')

          -- navigation
          vim.keymap.set('n', '<localleader>a', '<cmd>GoAlternate<cr>', opts 'Go: Alternate file')
        end,
      })
    end,
  },
}
