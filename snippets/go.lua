local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {
  s('iferr', {
    t { 'if err != nil {', '\treturn err', '}' },
  }),
}
