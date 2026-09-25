return {
  'lervag/vimtex',
  ft = { 'tex' },
  init = function()
    vim.g.vimtex_mappings_prefix = '<localleader>'
    vim.g.vimtex_view_method = 'skim'
    -- vim.g.vimtex_view_method = 'general' -- defaults to preview on mac, but has a issue where the pdf doesn't update until the window is given focus
    vim.g.vimtex_compiler_method = 'latexmk'

    -- Live preview compiles into a temp dir
    vim.g.vimtex_compiler_latexmk = {
      out_dir = vim.fn.stdpath 'cache' .. '/vimtex',
      continuous = 1,
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end,

  keys = {
    {
      ft = 'tex',
      '<localleader>C',
      function()
        local buf_dir = vim.fn.expand '%:p:h'
        local tex_file = vim.fn.expand '%:p'
        vim.fn.jobstart({
          'latexmk',
          '-pdf',
          '-interaction=nonstopmode',
          '-file-line-error',
          '-outdir=' .. buf_dir,
          tex_file,
        }, {
          stdout_buffered = true,
          on_exit = function(_, code)
            if code == 0 then
              vim.notify('Compiled to ' .. buf_dir, vim.log.levels.INFO)
            else
              vim.notify('Compilation failed', vim.log.levels.ERROR)
            end
          end,
        })
      end,
      desc = 'Compile PDF to buffer directory',
    },
  },

  -- Disable insert mode mappings if you use blink.cmp / snippets heavily
  -- vim.g.vimtex_mappings_disable = { ["n"] = {}, ["i"] = { "]]" } }
}
