-- autocmd.lua
-- Create a shared augroup to prevent duplicate autocmd triggers on config reload
local config_group = vim.api.nvim_create_augroup('UserCustomConfig', { clear = true })

-- 1. Filetype-specific wrap behavior
vim.api.nvim_create_autocmd('FileType', {
  group = config_group,
  pattern = {
    'c',
    'cpp',
    'python',
    'javascript',
    'typescript',
    'lua',
    'go',
    'rust',
    'ruby',
    'php',
    'markdown',
    'java',
  },
  callback = function()
    vim.opt_local.wrap = false
  end,
})

-- 2. LuaSnip LaTeX snippets setup
-- Safely initialize snippets on markdown filetype without using 'once = true'
vim.api.nvim_create_autocmd('FileType', {
  group = config_group,
  pattern = { 'markdown' },
  callback = function()
    local ok, luasnip_latex = pcall(require, 'luasnip-latex-snippets')
    if ok then
      luasnip_latex.setup { use_treesitter = true }
    end
  end,
})

-- 3. PDF compilation for Markdown / LaTeX
vim.api.nvim_create_autocmd('FileType', {
  group = config_group,
  pattern = { 'markdown', 'tex' },
  callback = function()
    -- Cross-platform system opener detection (macOS vs. Linux/WSL)
    local opener = vim.fn.has 'mac' == 1 and 'open' or 'xdg-open'

    local function render_pdf(out)
      local file = vim.fn.expand '%:p'
      local stderr_lines = {}

      vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
        stderr_buffered = true,
        on_stderr = function(_, data)
          if data then
            for _, line in ipairs(data) do
              if line ~= '' then
                table.insert(stderr_lines, line)
              end
            end
          end
        end,
        on_exit = function(_, code)
          if code == 0 then
            vim.fn.jobstart { opener, out }
          else
            local msg = table.concat(stderr_lines, '\n')
            vim.notify('Pandoc failed:\n' .. msg, vim.log.levels.ERROR)
          end
        end,
      })
    end

    vim.keymap.set('n', '<localleader>rp', function()
      render_pdf('/tmp/' .. vim.fn.expand '%:t:r' .. '.pdf')
    end, { buffer = true, desc = 'Preview as PDF (tmp)' })

    vim.keymap.set('n', '<localleader>rP', function()
      render_pdf(vim.fn.expand '%:p:r' .. '.pdf')
    end, { buffer = true, desc = 'Preview as PDF (same dir)' })
  end,
})

-- 4. Statusline override for non-picker floating windows
-- Excludes prompt / picker buffers to avoid breaking UI height calculations in snacks.picker
vim.api.nvim_create_autocmd('WinEnter', {
  group = config_group,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)

    if config.relative ~= '' then
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.bo[buf].buftype

      -- Avoid mutating prompt windows, pickers, or floating inputs
      if buftype ~= 'prompt' and buftype ~= 'nofile' then
        vim.wo[win].statusline = ' '
      end
    end
  end,
})

-- 5. Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = config_group,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- 6. Buffer-local color column toggle
local function toggle_colorcol()
  local cur_cc = vim.opt_local.colorcolumn:get()

  if #cur_cc == 0 then
    vim.opt_local.colorcolumn = '80'
    vim.notify('Color column enabled (80)', vim.log.levels.INFO)
  else
    vim.opt_local.colorcolumn = ''
    vim.notify('Color column disabled', vim.log.levels.INFO)
  end
end

vim.keymap.set('n', '<leader>Tc', toggle_colorcol, { desc = 'Toggle color column (80)' })
