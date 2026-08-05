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
    -- Format on save, unless disabled via :FormatDisable[!] (see below)
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500 }
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! disables formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable autoformat-on-save" })
  end,
}
