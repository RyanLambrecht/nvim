-- lazy.nvim
---@type LazySpec
return {
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>nn',
      function()
        Snacks.picker.notifications {
          confirm = function(picker, item)
            picker:close()
            if not item then
              return
            end

            local n = item.item or {}
            local text = n.msg or item.text or ''

            vim.cmd 'botright new'
            local buf = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, '\n'))
            vim.bo[buf].buftype = 'nofile'
            vim.bo[buf].bufhidden = 'wipe'
            vim.bo[buf].swapfile = false
            vim.bo[buf].filetype = n.ft or 'markdown'
            vim.bo[buf].modifiable = false
            vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, desc = 'Close' })
          end,
        }
      end,
      desc = 'Search Notifications',
    },
  },

  opts = {
    notifier = {
      style = 'minimal',
    },
  },
}
