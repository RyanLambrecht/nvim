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
vim.keymap.set('n', '<leader>nr', function()
  local session = vim.fn.stdpath 'state' .. '/restart_session.vim'
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session))
  vim.cmd('restart source ' .. vim.fn.fnameescape(session))
end, { desc = 'Restart Neovim' })
vim.keymap.set('n', '<leader>nc', ':%bd|e#<CR>', { desc = 'Clear other buffers' })

-- Misc
vim.keymap.set('n', '<leader>Ts', function()
  vim.opt.spell = not vim.opt.spell:get()
  print('Spell check: ' .. (vim.opt.spell:get() and 'ON' or 'OFF'))
end, { desc = 'Toggle spell check' })

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
