return {
  ["server1"] = {
    host = "server1",
    mappings = {
      {
        ["local"] = "domains/example.com",
        ["remote"] = "/var/www/example.com",
      },
    },
    -- excludedPaths = {
    --   "src", -- local path relative to project root
    -- },
  },
}
