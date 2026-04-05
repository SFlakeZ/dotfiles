
local M = {}

-- nvim-lint: https://github.com/mfussenegger/nvim-lint
M.lsp_by_ft = {
  sh = { "shellcheck" },
  python = { "ruff" },

  html = { "eslint_d" },
  css = { "eslint_d" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  json = { "eslint_d" },

  c = { "clang-tidy" },
  cpp = { "clang-tidy" },

  perl = { "perlcritic" },

  markdown = { "markdownlint" },

  make = { "checkmake" },

  toml = { "taplo" }
}

return M

