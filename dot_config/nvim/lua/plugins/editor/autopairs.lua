local is_enabled = require("core.utils").is_enabled("autopairs")

-- nvim-autopairs: https://github.com/windwp/nvim-autopairs
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = true,
  enabled = is_enabled,
}
