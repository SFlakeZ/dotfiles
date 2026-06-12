local is_enabled = require("core.utils").is_enabled("gitsigns")

-- gitsigns: https://github.com/lewis6991/gitsigns.nvim
return {
  "lewis6991/gitsigns.nvim",
  enabled = is_enabled,
}
