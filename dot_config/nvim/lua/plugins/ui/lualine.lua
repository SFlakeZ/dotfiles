local is_enabled = require("core.utils").is_enabled("lualine")

-- lualine: https://github.com/nvim-lualine/lualine.nvim
return {
  "nvim-lualine/lualine.nvim",
  enabled = is_enabled,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
      },
    })
  end,
}
