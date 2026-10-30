---@type LazySpec
return {
  {
    'fatih/vim-go',
    ft = 'go',
    build = ':GoInstallBinaries',
    keys = {
      {
        '<localleader>r',
        function()
          vim.cmd('GoRun ' .. vim.fn.getcwd())
        end,
        ft = 'go',
        desc = 'Go: Run',
      },
      { '<localleader>b', '<cmd>GoBuild .<cr>', ft = 'go', desc = 'Go: Build' },
      { '<localleader>t', '<cmd>GoTest<cr>', ft = 'go', desc = 'Go: Test' },
      { '<localleader>T', '<cmd>GoTestFunc<cr>', ft = 'go', desc = 'Go: Test func' },
      { '<localleader>c', '<cmd>GoCoverageToggle<cr>', ft = 'go', desc = 'Go: Coverage toggle' },
      { '<localleader>e', '<cmd>GoIfErr<cr>', ft = 'go', desc = 'Go: If err' },
      { '<localleader>f', '<cmd>GoFillStruct<cr>', ft = 'go', desc = 'Go: Fill struct' },
      { '<localleader>i', '<cmd>GoImpl<cr>', ft = 'go', desc = 'Go: Implement interface' },
      { '<localleader>a', '<cmd>GoAlternate<cr>', ft = 'go', desc = 'Go: Alternate file' },
      { '<localleader>ta', ':GoAddTags ', ft = 'go', desc = 'Go: Add tags' },
      { '<localleader>tr', ':GoRemoveTags ', ft = 'go', desc = 'Go: Remove tags' },
      { '<localleader>v', '<cmd>GoVet<cr>', ft = 'go', desc = 'Go: Vet' },
    },
    config = function()
      vim.g.go_diagnostics_enabled = 0
      vim.g.go_metalinter_enabled = {}
      vim.g.go_jump_to_error = 0
      vim.g.go_auto_sameids = 0

      -- Let LSP own these
      vim.g.go_doc_keywordprg_enabled = 0 -- fixes K → LSP hover float
      vim.g.go_def_mapping_enabled = 0 -- fixes gd → LSP definition
      vim.g.go_gopls_enabled = 0 -- don't spawn a second gopls
      vim.g.go_code_completion_enabled = 0 -- let blink.cmp handle it

      -- Let conform handle formatting (remove go_fmt_command)
      vim.g.go_fmt_autosave = 0
      vim.g.go_imports_autosave = 0

      -- Syntax highlighting (keep these, LSP doesn't do this)
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_generate_tags = 1

      vim.g.go_def_mode = 'gopls'
      vim.g.go_info_mode = 'gopls'
    end,
  },
}
