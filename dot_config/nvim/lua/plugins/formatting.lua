local is_enabled = require("core.utils").is_enabled("conform")
local formatters = require("core.utils").formatters_by_ft()

-- conform: https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  enabled = is_enabled,
  opts = {
    formatters_by_ft = formatters,
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
  },
}
