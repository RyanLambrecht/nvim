return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'iurimateus/luasnip-latex-snippets.nvim',
  },
  config = function()
    local ls = require 'luasnip'

    -- Math zone detection via Treesitter (no vimtex needed)
    local function in_mathzone()
      local node = vim.treesitter.get_node()
      if not node then
        return false
      end
      local t = node:type()
      return t == 'inline_formula' or t == 'displayed_equation'
    end

    -- Make the helper available globally to LuaSnip conditions
    require('luasnip.extras.conditions').make_condition(in_mathzone)

    -- Load latex snippets, scoped to markdown filetypes
    require('luasnip-latex-snippets').setup {
      use_treesitter = true, -- uses its own internal math zone check
      filetypes = { 'markdown', 'markdown_inline' },
    }

    local function leave_snippet()
      local old = vim.v.event.old_mode
      local new = vim.v.event.new_mode
      if ((old == 's' and new == 'n') or old == 'i') and ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
        ls.unlink_current()
      end
    end

    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = leave_snippet,
    })
  end,
}
-- return {
--   'L3MON4D3/LuaSnip',
--   config = function()
--     local ls = require 'luasnip'
--
--     local function leave_snippet()
--       local old = vim.v.event.old_mode
--       local new = vim.v.event.new_mode
--
--       if ((old == 's' and new == 'n') or old == 'i') and ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
--         ls.unlink_current()
--       end
--     end
--
--     -- Create the autocmd via Lua API (preferred over vim.api.nvim_command)
--     vim.api.nvim_create_autocmd('ModeChanged', {
--       pattern = '*',
--       callback = leave_snippet,
--     })
--   end,
-- }
