local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim

M.by_ft = {
  python = {
    mason_install = true,
    lsp = "basedpyright", -- "ruff", "pyright"
    linters = {}, -- provided by lsp
    formatters = { "ruff_format" },
  },
  perl = {
    mason_install = false,
    lsp = "perlnavigator",
    linters = {},
    formatters = {},
  },
  c = {
    mason_install = true,
    lsp = "clangd",
    linters = {}, -- provided by lsp (clang-tidy)
    formatters = { "clang-format" },
  },
  lua = {
    mason_install = true,
    lsp = "lua_ls",
    linters = {},
    formatters = { "stylua" },
  },
  rust = {
    mason_install = false,
    lsp = "rust_analyzer",
    linters = {},
    formatters = { "rustfmt" },
  },
  html = {
    mason_install = true,
    lsp = "html",
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  css = {
    mason_install = true,
    lsp = "cssls",
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  javascript = {
    mason_install = true,
    lsp = "ts_ls",
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  vue = {
    mason_install = true,
    lsp = "vue_ls",
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
}

M.by_ft.cpp = M.by_ft.c
M.by_ft.typescript = M.by_ft.javascript

return M
