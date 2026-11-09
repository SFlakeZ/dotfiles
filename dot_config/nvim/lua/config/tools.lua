local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim
--
-- 'lsp' is a list, some filetypes need several clients (e.g. vue)

M.by_ft = {
  python = {
    mason_install = true,
    lsp = { "basedpyright" }, -- "ruff", "pyright"
    linters = {}, -- provided by lsp
    formatters = { "ruff_format" },
  },
  perl = {
    mason_install = false,
    lsp = { "perlnavigator" },
    linters = {},
    formatters = {},
  },
  c = {
    mason_install = true,
    lsp = { "clangd" },
    linters = {},
    formatters = { "clang-format" },
  },
  lua = {
    mason_install = true,
    lsp = { "lua_ls" },
    linters = {},
    formatters = { "stylua" },
  },
  rust = {
    mason_install = false, -- managed with rustup
    lsp = { "rust_analyzer" },
    linters = {},
    formatters = { "rustfmt" },
  },
  html = {
    mason_install = true,
    lsp = { "html", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  css = {
    mason_install = true,
    lsp = { "cssls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  javascript = {
    mason_install = true,
    lsp = { "vtsls" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  java = {
    mason_install = true,
    lsp = { "jdtls" },
    linters = {}, -- provided by lsp
    formatters = { "google-java-format" },
  },
  kotlin = {
    mason_install = true,
    lsp = { "kotlin_lsp" },
    linters = {}, -- provided by lsp
    formatters = { "ktlint" },
  },
  vue = {
    mason_install = true,
    -- vue_ls: template/style; vtsls: TypeScript (hybrid mode); emmet/tailwindcss: template completions
    lsp = { "vue_ls", "vtsls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  go = {
    mason_install = false, -- managed with go install
    lsp = { "gopls" },
    linters = {},
    formatters = { "gofumpt" },
  },
  yaml = {
    mason_install = true,
    lsp = { "yamlls" },
    linters = {},
    formatters = { "prettier" },
  },
  json = {
    mason_install = true,
    lsp = { "jsonls" },
    linters = {},
    formatters = { "prettier" },
  },
  dockerfile = {
    mason_install = true,
    lsp = { "dockerls" },
    linters = {},
    formatters = {},
  },
  sh = {
    mason_install = true,
    lsp = { "bashls" },
    linters = {},
    formatters = { "shfmt" },
  },
  toml = {
    mason_install = true,
    lsp = { "taplo" },
    linters = {},
    formatters = {}, -- taplo formats via LSP (conform lsp_format = "fallback")
  },
}

M.by_ft.cpp = M.by_ft.c
M.by_ft.typescript = M.by_ft.javascript

return M
