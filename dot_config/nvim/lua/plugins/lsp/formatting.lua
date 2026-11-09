local utils = require("core.utils")
local is_enabled = utils.is_enabled("conform")
local formatters = utils.formatters_by_ft()

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
    -- Only when enabled in config/plugins.lua or via :FormatEnable[!]
    format_on_save = function(bufnr)
      if not utils.autoformat_enabled(bufnr) then
        return
      end
      return { timeout_ms = 500 }
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.g.autoformat = utils.option("conform", "format_on_save", false)

    -- With ! only the current buffer is changed
    local function set_autoformat(value, buffer_only)
      if buffer_only then
        vim.b.autoformat = value
      else
        vim.g.autoformat = value
        vim.b.autoformat = nil
      end
      vim.notify(("Format on save %s%s"):format(value and "on" or "off", buffer_only and " (buffer)" or ""))
    end

    vim.api.nvim_create_user_command("FormatEnable", function(args)
      set_autoformat(true, args.bang)
    end, { desc = "Enable format on save", bang = true })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      set_autoformat(false, args.bang)
    end, { desc = "Disable format on save", bang = true })

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      set_autoformat(not utils.autoformat_enabled(0), args.bang)
    end, { desc = "Toggle format on save", bang = true })

    vim.api.nvim_create_user_command("FormatInfo", function()
      local names = vim.tbl_map(function(f)
        return f.name
      end, require("conform").list_formatters(0))
      vim.notify(
        ("Format on save: %s\nFormatters: %s"):format(
          utils.autoformat_enabled(0) and "on" or "off",
          #names > 0 and table.concat(names, ", ") or "lsp (fallback)"
        )
      )
    end, { desc = "Show format on save state and formatters" })
  end,
}
