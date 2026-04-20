return {
  'wojciech-kulik/xcodebuild.nvim',
  ft = { 'swift' },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'stevearc/oil.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('xcodebuild').setup {
      code_coverage = {
        enabled = true,
      },
      project_manager = {
        should_update_project = function(_path)
          local root = vim.fn.getcwd()
          return vim.fn.glob(root .. '/*.xcodeproj') ~= '' or vim.fn.glob(root .. '/*.xcworkspace') ~= ''
        end,
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'swift',
      callback = function()
        -- Build & Run
        vim.keymap.set('n', '<localleader>l', '<cmd>XcodebuildToggleLogs<cr>', { buffer = true, desc = 'Toggle Xcodebuild Logs' })
        vim.keymap.set('n', '<localleader>b', '<cmd>XcodebuildBuild<cr>', { buffer = true, desc = 'Build Project' })
        vim.keymap.set('n', '<localleader>r', '<cmd>XcodebuildBuildRun<cr>', { buffer = true, desc = 'Build & Run Project' })
        vim.keymap.set('n', '<localleader>d', '<cmd>XcodebuildSelectDevice<cr>', { buffer = true, desc = 'Select Device' })
        vim.keymap.set('n', '<localleader>X', '<cmd>XcodebuildPicker<cr>', { buffer = true, desc = 'All Xcodebuild Actions' })
        -- Tests
        vim.keymap.set('n', '<localleader>t', '<cmd>XcodebuildTest<cr>', { buffer = true, desc = 'Run Tests' })
        vim.keymap.set('n', '<localleader>T', '<cmd>XcodebuildTestClass<cr>', { buffer = true, desc = 'Run This Test Class' })
        vim.keymap.set('n', '<localleader>p', '<cmd>XcodebuildSelectTestPlan<cr>', { buffer = true, desc = 'Select Test Plan' })
        vim.keymap.set('n', '<localleader>q', '<cmd>Telescope quickfix<cr>', { buffer = true, desc = 'Show QuickFix List' })
        -- Coverage
        vim.keymap.set('n', '<localleader>c', '<cmd>XcodebuildToggleCodeCoverage<cr>', { buffer = true, desc = 'Toggle Code Coverage' })
        vim.keymap.set('n', '<localleader>C', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { buffer = true, desc = 'Coverage Report' })
      end,
    })

    -- claude evil code for lazr
    vim.api.nvim_create_user_command('XBS', function()
      local scheme
      -- For Swift packages, read the name from Package.swift directly
      if vim.fn.filereadable 'Package.swift' == 1 then
        local pkg = io.open 'Package.swift'
        if pkg then
          local contents = pkg:read '*a'
          pkg:close()
          scheme = contents:match 'name:%s*"([^"]+)"'
        end
      end
      -- For Xcode projects/workspaces, use xcodebuild -list
      if not scheme then
        local handle = io.popen 'xcodebuild -list 2>/dev/null'
        if handle then
          local result = handle:read '*a'
          handle:close()
          scheme = result:match 'Schemes:\n%s+(%S+)'
        end
      end
      if not scheme then
        vim.notify('No schemes found', vim.log.levels.ERROR)
        return
      end
      local cmd
      if vim.fn.glob '*.xcworkspace' ~= '' then
        cmd = 'xcode-build-server config -workspace ' .. vim.fn.glob '*.xcworkspace' .. ' -scheme ' .. scheme
      elseif vim.fn.glob '*.xcodeproj' ~= '' then
        cmd = 'xcode-build-server config -project ' .. vim.fn.glob '*.xcodeproj' .. ' -scheme ' .. scheme
      elseif vim.fn.filereadable 'Package.swift' == 1 then
        cmd = 'xcode-build-server config -project . -scheme ' .. scheme
      else
        vim.notify('No Xcode project, workspace, or Package.swift found', vim.log.levels.ERROR)
        return
      end
      vim.notify('Configuring xcode-build-server with scheme: ' .. scheme)
      require('toggleterm.terminal').Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
    end, {})
  end,
}
