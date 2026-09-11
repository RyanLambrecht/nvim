local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s('tex', {
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
  s('sym', {
    t '\\mathbb{',
    i(1, 'Z/R/Q/N/etc'),
    t '}',
  }),
}
