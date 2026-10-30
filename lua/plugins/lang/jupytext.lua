---@type LazySpec
return {
  'GCBallesteros/jupytext.nvim',
  event = {
    'BufReadPre *.ipynb',
    'BufNewFile *.ipynb',
  },
  -- opts = {
  --   style = 'markdown',
  --   output_extension = 'md',
  --   force_ft = 'markdown',
  -- },
  opts = {
    style = 'percent',
    output_extension = 'py',
    force_ft = 'python',
  },
}
