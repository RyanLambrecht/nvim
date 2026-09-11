return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'iurimateus/luasnip-latex-snippets.nvim',
  },
  config = function()
    local ls = require 'luasnip'

    -- Math zone condition using treesitter
    local function in_mathzone()
      local node = vim.treesitter.get_node()
      if not node then
        return false
      end
      local t = node:type()
      return t == 'inline_formula' or t == 'displayed_equation'
    end
    require('luasnip.extras.conditions').make_condition(in_mathzone)

    -- filetype_extend BEFORE setup so the library sees it
    ls.filetype_extend('markdown', { 'tex' })

    -- Setup latex snippets exactly once
    local latex_snippets_loaded = false
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'tex' },
      callback = function()
        if not latex_snippets_loaded then
          latex_snippets_loaded = true
          require('luasnip-latex-snippets').setup { use_treesitter = true }
        end
      end,
    })

    -- Also fire immediately for any already-open buffer
    local ft = vim.bo.filetype
    if ft == 'markdown' or ft == 'tex' then
      latex_snippets_loaded = true
      require('luasnip-latex-snippets').setup { use_treesitter = true }
    end

    -- Snippet unlink on mode change
    local function leave_snippet()
      ---@diagnostic disable-next-line: undefined-field
      local old = vim.v.event.old_mode
      ---@diagnostic disable-next-line: undefined-field
      local new = vim.v.event.new_mode
      if ((old == 's' and new == 'n') or old == 'i') and ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
        ls.unlink_current()
      end
    end
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = leave_snippet,
    })

    require('luasnip.loaders.from_lua').load {
      paths = { vim.fn.stdpath 'config' .. '/snippets' },
    }
  end,
}
