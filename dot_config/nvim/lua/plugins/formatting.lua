
local is_enabled = require("core.utils").is_enabled("conform")
local formatters = require("config.formatting").formatters_by_ft

-- conform: https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  enabled = is_enabled,
  opts = {
    formatters_by_ft = formatters
  },
  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end
      })
  end
}

