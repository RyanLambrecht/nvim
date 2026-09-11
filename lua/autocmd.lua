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

-- makes pdf of markdown or latex file in buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'tex' },
  callback = function()
    vim.keymap.set('n', '<localleader>rp', function()
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

    vim.keymap.set('n', '<localleader>rP', function()
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
-- makes pdf of markdown or latex file in buffer
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown', 'tex' },
--   callback = function()
--     vim.keymap.set('n', '<localleader>rp', function()
--       local file = vim.fn.expand '%:p'
--       local out = '/tmp/' .. vim.fn.expand '%:t:r' .. '.pdf'
--       vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
--         on_exit = function(_, code)
--           if code == 0 then
--             vim.fn.jobstart { 'open', out }
--           else
--             vim.notify('Pandoc failed', vim.log.levels.ERROR)
--           end
--         end,
--       })
--     end, { buffer = true, desc = 'Preview as PDF (tmp)' })
--
--     vim.keymap.set('n', '<localleader>rP', function()
--       local file = vim.fn.expand '%:p'
--       local out = vim.fn.expand '%:p:r' .. '.pdf'
--       vim.fn.jobstart({ 'pandoc', file, '-o', out, '--pdf-engine=xelatex' }, {
--         on_exit = function(_, code)
--           if code == 0 then
--             vim.fn.jobstart { 'open', out }
--           else
--             vim.notify('Pandoc failed', vim.log.levels.ERROR)
--           end
--         end,
--       })
--     end, { buffer = true, desc = 'Preview as PDF (same dir)' })
--   end,
-- })

-- gets rid of airline attatching itself to floating buf
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.wo[win].statusline = ' '
        end
      end, 10)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Toggle a single‑column color column (80 chars by default)
local function toggle_colorcol()
  -- Grab the current global value – it can be a comma‑separated list as well.
  local cur_cc = vim.opt.colorcolumn:get()

  -- If the option is empty or nil → no column → turn it on.
  if cur_cc == '' or cur_cc == nil then
    vim.opt.colorcolumn = '80' -- change the number if you prefer something else
    vim.notify('Color column enabled (80)', vim.log.levels.INFO)
  else
    vim.opt.colorcolumn = '' -- clear the option → turn it off
    vim.notify('Color column disabled', vim.log.levels.INFO)
  end
end

-- Normal‑mode mapping: <leader>cc  (you can pick any key‑combo you like)
vim.keymap.set('n', '<leader>Tc', toggle_colorcol, { desc = 'Toggle color column (80) – <leader>cc' })
