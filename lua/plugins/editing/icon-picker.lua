local file_types = { 'markdown', 'text' }

local function inside_brackets()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(1, col)
  local after = line:sub(col + 1)
  return (before:match '%(' and after:match '%)') or (before:match '{' and after:match '}') or (before:match '%[' and after:match '%]')
end

return {
  'ziontee113/icon-picker.nvim',
  ft = file_types,
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = file_types,
      callback = function(ev)
        local opts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set('n', '<localleader>i', '<cmd>IconPickerNormal<cr>', opts)
        vim.keymap.set('n', '<localleader>y', '<cmd>IconPickerYank<cr>', opts)
        vim.keymap.set('i', '<C-,>', function()
          -- bullshit fix for when inside of brackets
          if inside_brackets() then
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_win_set_cursor(0, { row, col + 1 })
          end
          vim.cmd 'IconPickerInsert'
        end, opts)
      end,
    })
  end,
}
