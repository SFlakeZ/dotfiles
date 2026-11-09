local is_enabled = require("core.utils").is_enabled("diffview")

-- diffview-plus: https://github.com/dlyongemallo/diffview-plus.nvim
-- maintained fork of sindrets/diffview.nvim
return {
  "dlyongemallo/diffview-plus.nvim",
  version = "*",
  enabled = is_enabled,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewToggle", "DiffviewClose", "DiffviewFileHistory" },
  opts = {},
}
