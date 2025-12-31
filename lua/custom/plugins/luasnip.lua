return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require 'luasnip'

    local function leave_snippet()
      local old = vim.v.event.old_mode
      local new = vim.v.event.new_mode

      if ((old == 's' and new == 'n') or old == 'i') and ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
        ls.unlink_current()
      end
    end

    -- Create the autocmd via Lua API (preferred over vim.api.nvim_command)
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = leave_snippet,
    })
  end,
}
