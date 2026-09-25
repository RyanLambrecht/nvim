return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local clock = function()
      return os.date '%H:%M'
    end

    require('lualine').setup {
      options = {
        theme = 'auto',
        powerline_fonts = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- this is the key one - don't render in floats
        globalstatus = false,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location', clock },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      -- explicitly exclude floats
      extensions = {},
    }
  end,
}
