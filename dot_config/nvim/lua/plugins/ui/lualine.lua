local utils = require("core.utils")
local is_enabled = utils.is_enabled("lualine")

-- Shown while format on save is active for the current buffer
local autoformat = {
  function()
    return "󰉼 fmt"
  end,
  cond = function()
    return utils.is_enabled("conform") and utils.autoformat_enabled(0)
  end,
}

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
      sections = {
        lualine_x = { autoformat, "encoding", "fileformat", "filetype" },
      },
    })
  end,
}
