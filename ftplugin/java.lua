-- JDTLS (Java LSP) configuration
vim.schedule(function()
  local home = vim.env.HOME
  local jdtls = require 'jdtls'
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = home .. '/jdtls-workspace/' .. project_name
  local java_home_path = vim.env.JAVA_HOME or vim.fn.trim(vim.fn.system '/usr/libexec/java_home')
  local java_bin = java_home_path .. '/bin/java'

  -- Determine OS
  local system_os = ''
  if vim.fn.has 'mac' == 1 then
    system_os = 'mac'
  elseif vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
    system_os = 'win'
  elseif vim.fn.has 'unix' == 1 then
    system_os = 'linux'
  else
    print "OS not found, defaulting to 'linux'"
    system_os = 'linux'
  end

  -- Needed for debugging
  local bundles = {
    vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
  }

  -- Needed for running/debugging unit tests
  vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), '\n'))

  -- ─── Helper ──────────────────────────────────────────────────────────────────

  ---@param client vim.lsp.Client
  ---@param method vim.lsp.protocol.Method
  ---@param bufnr? integer
  ---@return boolean
  local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
      return client:supports_method(method, bufnr)
    else
      return client.supports_method(method, { bufnr = bufnr })
    end
  end

  -- ─── Config ──────────────────────────────────────────────────────────────────

  local lombok_path = home .. '/.local/share/nvim/mason/share/jdtls/lombok.jar'

  -- Java home: prefer JAVA_HOME env var, fall back to platform detection
  local java_home = java_home_path

  local config = {
    cmd = {
      java_bin,
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-javaagent:' .. lombok_path,
      '-Xmx4g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-jar',
      home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
      '-configuration',
      home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. system_os,
      '-data',
      workspace_dir,
    },

    root_dir = require('jdtls.setup').find_root { '.root', '.git', 'mvnw', 'pom.xml', 'build.gradle', 'README.md', 'src' } or vim.fn.getcwd(),

    settings = {
      java = {
        home = java_home,
        eclipse = { downloadSources = true },
        configuration = {
          updateBuildConfiguration = 'interactive',
          runtimes = {
            -- Add / remove runtimes to match what's installed on your machine.
            -- On macOS you can find paths with: /usr/libexec/java_home -V
            -- On Linux check: ls /usr/lib/jvm/
            {
              name = 'JavaSE-25',
              path = '/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home',
            },
          },
        },
        project = {
          sourcePaths = { 'src/main', 'src/test' },
        },
        maven = { downloadSources = true },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        signatureHelp = { enabled = true },
        format = { enabled = true },
        inlayHints = {
          parameterNames = { enabled = 'all' }, -- 'none' | 'literals' | 'all'
        },
        completion = {
          favoriteStaticMembers = {
            'org.hamcrest.MatcherAssert.assertThat',
            'org.hamcrest.Matchers.*',
            'org.hamcrest.CoreMatchers.*',
            'org.junit.jupiter.api.Assertions.*',
            'java.util.Objects.requireNonNull',
            'java.util.Objects.requireNonNullElse',
            'org.mockito.Mockito.*',
          },
          importOrder = { 'java', 'javax', 'com', 'org' },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
          },
          useBlocks = true,
        },
      },
    },

    capabilities = require('blink.cmp').get_lsp_capabilities(),
    flags = { allow_incremental_sync = true },
    init_options = {
      bundles = bundles,
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
    },
  }

  -- ─── On Attach ───────────────────────────────────────────────────────────────

  config['on_attach'] = function(client, bufnr)
    -- DAP setup
    jdtls.setup_dap { hotcodereplace = 'auto' }
    require('jdtls.dap').setup_dap_main_class_configs()

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    -- ── Standard LSP keymaps (mirror lspconfig.lua since jdtls bypasses LspAttach) ──
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
    map('grr', require('telescope.builtin').lsp_references, '[R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[I]mplementations')
    map('grd', require('telescope.builtin').lsp_definitions, '[D]efinition')
    map('grD', vim.lsp.buf.declaration, '[D]eclaration')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[T]ype Definition')
    map('K', vim.lsp.buf.hover, 'Hover Documentation') -- FIX: was hover() not hover

    -- ── Java-specific keymaps ──────────────────────────────────────────────────

    -- Imports & refactoring
    map('<localleader>o', jdtls.organize_imports, 'Java: [O]rganize Imports')
    map('<localleader>v', jdtls.extract_variable, 'Java: Extract [V]ariable')
    map('<localleader>v', function()
      jdtls.extract_variable(true)
    end, 'Java: Extract [V]ariable (visual)', 'v')
    map('<localleader>c', jdtls.extract_constant, 'Java: Extract [C]onstant')
    map('<localleader>c', function()
      jdtls.extract_constant(true)
    end, 'Java: Extract [C]onstant (visual)', 'v')
    map('<localleader>m', function()
      jdtls.extract_method(true)
    end, 'Java: Extract [M]ethod', 'v')

    -- Build
    map('<localleader>b', function()
      jdtls.compile 'incremental'
    end, 'Java: [B]uild (incremental)')
    map('<localleader>B', function()
      jdtls.compile 'full'
    end, 'Java: [B]uild Full')

    -- Testing (requires java-test bundle)
    map('<localleader>t', jdtls.test_nearest_method, 'Java: [T]est Nearest Method')
    map('<localleader>T', jdtls.test_class, 'Java: [T]est Class')
    map('<localleader>u', function()
      require('jdtls').update_projects_config()
    end, 'Java: [U]pdate Project Config')

    -- run
    map('<localleader>r', function()
      local root = require('jdtls.setup').find_root { '.git', 'mvnw', 'pom.xml', 'build.gradle', 'README.md', 'src' } or vim.fn.getcwd()
      require('toggleterm.terminal').Terminal
        :new({
          cmd = "cd '" .. root .. '\' && javac -cp "lib/*" -d out $(find src/main -name "*.java") && java -cp "out:lib/*" ui.Main',
          direction = 'horizontal',
          close_on_exit = false,
        })
        :toggle()
    end, 'Java: [R]un Project')

    -- ── Inlay hints toggle ─────────────────────────────────────────────────────
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
      end, '[T]oggle Inlay [H]ints')
    end

    -- ── Reference highlighting ─────────────────────────────────────────────────
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
      local highlight_augroup = vim.api.nvim_create_augroup('jdtls-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('jdtls-lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'jdtls-lsp-highlight', buffer = event.buf }
        end,
      })
    end
  end

  -- ─── Start ───────────────────────────────────────────────────────────────────

  jdtls.start_or_attach(config)
end) -- vim.schedule
