-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    -- nvim-jdtls handles Java DAP setup itself via jdtls.setup_dap(),
    -- which is called in its on_attach (see lua/custom/plugins/jdtls.lua).
    -- We list it here as a dependency so DAP is always ready before any
    -- Java buffer tries to attach to it.
    'mfussenegger/nvim-jdtls',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve', -- Go debugger

        -- Java debug adapter. Enables breakpoints, step-through debugging etc.
        -- for Java via nvim-jdtls. Install java-test too if you want to run
        -- individual JUnit tests from inside Neovim.
        'java-debug-adapter',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- Swift / Xcode debugging via xcodebuild.nvim
    local ok, xcodebuild = pcall(require, 'xcodebuild.integrations.dap')
    if ok then
      xcodebuild.setup()
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'swift',
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>dd', function()
          require('xcodebuild.integrations.dap').build_and_debug()
        end, vim.tbl_extend('force', opts, { desc = 'Debug: Build & Debug (Swift)' }))
        vim.keymap.set('n', '<leader>dr', function()
          require('xcodebuild.integrations.dap').debug_without_build()
        end, vim.tbl_extend('force', opts, { desc = 'Debug: Attach Debugger (Swift)' }))
        vim.keymap.set('n', '<leader>dt', function()
          require('xcodebuild.integrations.dap').debug_tests()
        end, vim.tbl_extend('force', opts, { desc = 'Debug: Debug Tests (Swift)' }))
        vim.keymap.set('n', '<leader>dx', function()
          require('xcodebuild.integrations.dap').terminate_session()
        end, vim.tbl_extend('force', opts, { desc = 'Debug: Terminate (Swift)' }))
      end,
    })

    -- NOTE: Java DAP does NOT need manual configuration here.
    -- Unlike Go (which uses nvim-dap-go), Java's debug adapter is bundled
    -- inside jdtls itself. The setup is handled automatically by calling
    -- jdtls.setup_dap() inside the on_attach of lua/custom/plugins/jdtls.lua.
    -- All your normal debug keymaps (<F5>, <F1>, <F2>, etc.) will work for
    -- Java the same way they do for Go once jdtls is attached to a buffer.
  end,
}
