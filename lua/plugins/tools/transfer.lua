return {
  'coffebar/transfer.nvim',
  lazy = true,
  cmd = { 'TransferInit', 'DiffRemote', 'TransferUpload', 'TransferDownload', 'TransferDirDiff', 'TransferRepeat' },
  keys = {
    { '<leader>ru', '<cmd>TransferUpload<cr>', desc = 'Remote: upload' },
    { '<leader>rd', '<cmd>TransferDownload<cr>', desc = 'Remote: download' },
    { '<leader>rf', '<cmd>DiffRemote<cr>', desc = 'Remote: diff file' },
    { '<leader>rD', '<cmd>TransferDirDiff<cr>', desc = 'Remote: diff directory' },
    { '<leader>rr', '<cmd>TransferRepeat<cr>', desc = 'Remote: repeat last' },
    { '<leader>ri', '<cmd>TransferInit<cr>', desc = 'Remote: init/edit config' },
  },
  opts = {},
}
