local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

return {
  s(
    { trig = 'begin', name = 'begin/end (mirror)', priority = 2000 },
    fmta(
      [[
    \begin{<>}
    	<>
    \end{<>}
  ]],
      { i(1), i(0), rep(1) }
    )
  ),
  s('tex', {
    t '$',
    i(1, ''),
    t '$',
    i(2, ''),
  }),
  s('pd', {
    t '\\partial ',
  }),
  s('iint', {
    t '\\iint_R ',
  }),
  s('iiint', {
    t '\\iiint_E ',
  }),
  s('tf', {
    t '∴',
  }),
  s('fa', {
    t '∀',
  }),
  s('ex', {
    t '∃',
  }),
  s('fa', {
    t '∀',
  }),
  s('in', {
    t '∈',
  }),
  s('xor', {
    t '(+)',
  }),
  s('dm', {
    t { '\\[', '  ' },
    i(1),
    t { '', '\\]' },
  }),
  s('dam', {
    t { '\\[', '\\begin{aligned}', '  ' },
    i(1),
    t { '  ', '\\end{aligned}', '\\]' },
  }),
  s('aline', {
    t { '& ' },
    i(1),
    t { ' \\\\' },
  }),
}
