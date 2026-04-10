
local is_enabled = require("core.utils").is_enabled("conform")
local formatters = require("core.utils").formatters_by_ft()

-- conform: https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  enabled = is_enabled,
  opts = {
    formatters_by_ft = formatters
  },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback"
      }
    })
  end
}

