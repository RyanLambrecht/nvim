-- See `:help vim.keymap.set()`

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float { focusable = true }
end, { desc = 'Expand error into float' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- Split resizing
vim.keymap.set('n', '<M-Left>', '5<C-w><', { desc = 'Resize split left' })
vim.keymap.set('n', '<M-Right>', '5<C-w>>', { desc = 'Resize split right' })
vim.keymap.set('n', '<M-Up>', '5<C-w>+', { desc = 'Resize split up' })
vim.keymap.set('n', '<M-Down>', '5<C-w>-', { desc = 'Resize split down' })

-- Terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-p>', '<Up>', { desc = 'Previous terminal command' })
vim.keymap.set('t', '<C-n>', '<Down>', { desc = 'Next terminal command' })

-- Neovim

vim.keymap.set('n', '<leader>nr', ':restart!<cr>', { desc = '[r]estart!' })

vim.keymap.set('n', '<leader>nc', function()
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd('bdelete ' .. buf)
    end
  end
end, { desc = '[c]lear other buffers' })

vim.keymap.set('n', '<leader>nC', ':%bd<cr>', { desc = '[c]lear all buffers' })

-- Misc
-- vim.keymap.set('n', '<leader>Ts', function()
--   vim.opt.spell = not vim.opt.spell:get()
--   print('Spell check: ' .. (vim.opt.spell:get() and 'ON' or 'OFF'))
-- end, { desc = 'Toggle spell check' })

vim.keymap.set('n', '<leader>R', function()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  for _, client in ipairs(clients) do
    if client.config.root_dir then
      vim.fn.chdir(client.config.root_dir)
      vim.notify('cwd → ' .. client.config.root_dir)
      return
    end
  end
  vim.notify('No LSP root found', vim.log.levels.WARN)
end, { desc = 'CD to LSP root' })

vim.keymap.set('n', '<leader>F', function()
  local floats = vim.tbl_filter(function(w)
    if vim.api.nvim_win_get_config(w).relative == '' then
      return false
    end
    local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
    return not name:match '%[Pager%]' and not name:match '%[Cmd%]' and not name:match '%[Msg%]' and not name:match '%[Dialog%]'
  end, vim.api.nvim_list_wins())

  if #floats == 0 then
    vim.notify('No floating window found', vim.log.levels.WARN)
    return
  end

  local win = math.max(unpack(floats))
  local buf = vim.api.nvim_win_get_buf(win)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local ft = vim.bo[buf].filetype
  vim.api.nvim_win_close(win, true)

  vim.cmd 'belowright split'
  vim.api.nvim_win_set_height(0, math.min(15, #lines))
  local new_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, new_buf)
  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)
  vim.bo[new_buf].filetype = ft
  vim.bo[new_buf].modifiable = false
end, { desc = 'Float: move to split' })

-- easy insert & for matrix
vim.keymap.set('i', '<C-e>', '& ', { desc = 'insert space for matrix' })
