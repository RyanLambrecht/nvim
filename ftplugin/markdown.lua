local function fix_spelling()
  local word = vim.fn.expand '<cword>'
  local bad = vim.fn.spellbadword(word)
  if bad[1] ~= '' then
    vim.cmd 'normal! 1z=' -- already on a bad word, fix it directly
  else
    vim.cmd 'normal! ]s1z=' -- not on one, jump to the next and fix it
  end
end

vim.keymap.set('n', '<localleader>s', fix_spelling, { buffer = true, desc = 'Fix spelling (current or next)' })
