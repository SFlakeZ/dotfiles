local is_enabled = require("core.utils").is_enabled("telescope")

-- Telescope: https://github.com/nvim-telescope/telescope.nvim
return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  enabled = is_enabled,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}
