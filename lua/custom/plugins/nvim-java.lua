return {
  'nvim-java/nvim-java',
  config = function()
    require('java').setup {
      workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace',
      project_folders = { vim.fn.getcwd() .. '/src' }, -- tell jdtls that 'src' is the source root
    }
    vim.lsp.enable 'jdtls'
  end,
}
