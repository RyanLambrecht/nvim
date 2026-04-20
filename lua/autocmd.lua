-- Filetype-specific wrap behavior

vim.api.nvim_create_autocmd('FileType', {
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function()
    require('luasnip-latex-snippets').setup { use_treesitter = true }
  end,
  once = true, -- only register snippets once
})

--Makes rendered preview for md/tex
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'tex' },
  callback = function()
    vim.keymap.set('n', '<leader>mp', function()
      local file = vim.fn.expand '%:p'
      local out = '/tmp/' .. vim.fn.expand '%:t:r' .. '.pdf'
      vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
        on_exit = function(_, code)
          if code == 0 then
            vim.fn.jobstart { 'open', out } -- macOS; use 'zathura' or 'evince' on Linux
          else
            vim.notify('Pandoc failed', vim.log.levels.ERROR)
          end
        end,
      })
    end, { buffer = true, desc = 'Preview as PDF' })
  end,
})

-- makes pdf of markdown or latex file in buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'tex' },
  callback = function()
    vim.keymap.set('n', '<leader>mp', function()
      local file = vim.fn.expand '%:p'
      local out = '/tmp/' .. vim.fn.expand '%:t:r' .. '.pdf'
      vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
        on_exit = function(_, code)
          if code == 0 then
            vim.fn.jobstart { 'open', out }
          else
            vim.notify('Pandoc failed', vim.log.levels.ERROR)
          end
        end,
      })
    end, { buffer = true, desc = 'Preview as PDF (tmp)' })

    vim.keymap.set('n', '<leader>mP', function()
      local file = vim.fn.expand '%:p'
      local out = vim.fn.expand '%:p:r' .. '.pdf'
      vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
        on_exit = function(_, code)
          if code == 0 then
            vim.fn.jobstart { 'open', out }
          else
            vim.notify('Pandoc failed', vim.log.levels.ERROR)
          end
        end,
      })
    end, { buffer = true, desc = 'Preview as PDF (same dir)' })
  end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown', 'text' },
--   callback = function()
--     vim.opt_local.wrap = true
--   end,
-- })
