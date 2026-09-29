local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
--local fmt = require('luasnip.extras.fmt').fmt

return {
  s('texln', {
    t '$',
    i(1, ''),
    t '$',
    i(2, ''),
    t '  ',
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
  s('from', {
    t '_{',
    i(1, ''),
    t '}',
  }),
}
