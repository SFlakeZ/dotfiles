local is_enabled = require("core.utils").is_enabled("which_key")

-- which-key: https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  enabled = is_enabled,
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>u", group = "toggle" },
    },
  },
}
