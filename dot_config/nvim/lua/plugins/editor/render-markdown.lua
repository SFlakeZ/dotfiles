local is_enabled = require("core.utils").is_enabled("render_markdown")

-- render-markdown: https://github.com/meanderingprogrammer/render-markdown.nvim
return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = is_enabled,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {},
  ft = { "markdown" },
}
