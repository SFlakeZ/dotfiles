
local M = {}

-- conform: https://github.com/stevearc/conform.nvim
M.formatters_by_ft = {
  -- You can customize some of the format options
  -- for a filetype (:help conform.format)
  --
  -- Conform will run the first available formatter
  -- javascript = { "prettierd", "prettier", stop_after_first = true }
  sh = { "shfmt" },
  python = { "ruff" },
  html = { "prettier" },
  css = { "prettier" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  json = { "prettier" },
  markdown = { "prettier" },
  yaml = { "prettier" },
  c = { "clang-format" },
  cpp = { "clang-format" },
  lua = { "stylua" },
  rust = { "rustfmt" }
}

return M

