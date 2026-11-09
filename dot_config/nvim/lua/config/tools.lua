local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim
--
-- 'lsp' is a list, some filetypes need several clients (e.g. vue)
-- 'tools' are extra mason packages an lsp calls on its own (e.g. shellcheck)

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
    lsp = { "docker_language_server" }, -- also covers compose files
    linters = { "hadolint" },
    formatters = {},
  },
  helm = {
    mason_install = true,
    lsp = { "helm_ls" },
    linters = {},
    formatters = {},
  },
  ansible = {
    mason_install = true,
    lsp = { "ansiblels" },
    linters = {}, -- ansiblels runs ansible-lint
    formatters = {},
    tools = { "ansible-lint" },
  },
  jinja = {
    mason_install = true,
    lsp = { "jinja_lsp" },
    linters = {},
    formatters = {},
  },
  systemd = {
    mason_install = true,
    lsp = { "systemd_lsp" }, -- podman quadlets
    linters = {},
    formatters = {},
  },
  sh = {
    mason_install = true,
    lsp = { "bashls" },
    linters = {}, -- bashls runs shellcheck
    formatters = { "shfmt" },
    tools = { "shellcheck" },
  },
  markdown = {
    mason_install = true,
    lsp = { "marksman" },
    linters = {},
    formatters = { "prettier" },
  },
  ruby = {
    mason_install = false, -- ruby-lsp and rubocop come from the project's bundle
    lsp = { "ruby_lsp" },
    linters = {}, -- rubocop via ruby_lsp
    formatters = {}, -- rubocop via ruby_lsp (lsp_format = "fallback")
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
M.by_ft.javascriptreact = M.by_ft.javascript
M.by_ft.typescriptreact = M.by_ft.javascript

return M
