local is_enabled = require("core.utils").is_enabled("lazydev")

-- lazydev: https://github.com/folke/lazydev.nvim
return {
  "folke/lazydev.nvim",
  enabled = is_enabled,
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
