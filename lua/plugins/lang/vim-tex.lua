---@type LazySpec
return {
  'lervag/vimtex',
  -- lazy = false, -- vimtex lazy-loads itself via ftplugin; ft= breaks inverse search
  ft = { 'tex', 'bib', 'cls' },
  init = function()
    vim.g.vimtex_matchparen_enabled = 0
    vim.g.vimtex_mappings_prefix = '<localleader>l'
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_imaps_enabled = 0 -- luasnip-latex-snippets handles this

    vim.g.vimtex_compiler_latexmk = {
      out_dir = vim.fn.stdpath 'cache' .. '/vimtex',
    }
  end,

  keys = {
    {
      '<localleader>P', -- avoids clobbering vimtex's clean-full (<localleader>C)
      ft = 'tex',
      function()
        local buf_dir = vim.fn.expand '%:p:h'
        vim.fn.jobstart({
          'latexmk',
          '-pdf',
          '-interaction=nonstopmode',
          '-file-line-error',
          '-outdir=' .. buf_dir,
          vim.fn.expand '%:p',
        }, {
          on_exit = function(_, code)
            vim.notify(code == 0 and ('Compiled to ' .. buf_dir) or 'Compilation failed', code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
          end,
        })
      end,
      desc = 'Compile PDF to buffer directory',
    },
  },
}
