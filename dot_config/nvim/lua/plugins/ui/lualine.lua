
local is_enabled = require("core.utils").is_enabled("lualine")

-- lualine: https://github.com/nvim-lualine/lualine.nvim
return {
  "nvim-lualine/lualine.nvim",
  enabled = is_enabled,
  opts = {
      theme = "horizon"
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  }
}

