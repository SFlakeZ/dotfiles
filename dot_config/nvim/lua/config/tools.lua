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
    linters = {},
    formatters = { "clang-format" },
  },
  lua = {
    mason_install = true,
    lsp = "lua_ls",
    linters = {},
    formatters = { "stylua" },
  },
  rust = {
    mason_install = false, -- managed with rustup
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
  go = {
    mason_install = false, -- managed with go install
    lsp = "gopls",
    linters = {},
    formatters = { "gofumpt" },
  },
  yaml = {
    mason_install = true,
    lsp = "yamlls",
    linters = {},
    formatters = { "prettier" },
  },
  json = {
    mason_install = true,
    lsp = "jsonls",
    linters = {},
    formatters = { "prettier" },
  },
  dockerfile = {
    mason_install = true,
    lsp = "dockerls",
    linters = {},
    formatters = {},
  },
  sh = {
    mason_install = true,
    lsp = "bashls",
    linters = {},
    formatters = { "shfmt" },
  },
}

M.by_ft.cpp = M.by_ft.c
M.by_ft.typescript = M.by_ft.javascript

return M
