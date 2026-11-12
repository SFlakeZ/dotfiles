local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim
--
-- 'lsp' is a list, some filetypes need several clients (e.g. vue)
-- 'tools' are extra mason packages an lsp calls on its own (e.g. shellcheck)
-- 'install' is who installs the tools: "mason", or "system" for a package
-- manager, rustup, go install, ... (lsp, linters and formatters are used either way)

M.by_ft = {
  python = {
    install = "mason",
    lsp = { "basedpyright" }, -- "ruff", "pyright"
    linters = {}, -- provided by lsp
    formatters = { "ruff_format" },
  },
  perl = {
    install = "system",
    lsp = { "perlnavigator" },
    linters = {},
    formatters = {},
  },
  c = {
    install = "mason",
    lsp = { "clangd" },
    linters = {},
    formatters = { "clang-format" },
  },
  lua = {
    install = "mason",
    lsp = { "lua_ls" },
    linters = {},
    formatters = { "stylua" },
  },
  rust = {
    install = "system", -- managed with rustup
    lsp = { "rust_analyzer" },
    linters = {},
    formatters = { "rustfmt" },
  },
  html = {
    install = "mason",
    lsp = { "html", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  css = {
    install = "mason",
    lsp = { "cssls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  javascript = {
    install = "mason",
    lsp = { "vtsls" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  java = {
    install = "mason",
    lsp = { "jdtls" },
    linters = {}, -- provided by lsp
    formatters = { "google-java-format" },
  },
  kotlin = {
    install = "mason",
    lsp = { "kotlin_lsp" },
    linters = {}, -- provided by lsp
    formatters = { "ktlint" },
  },
  vue = {
    install = "mason",
    -- vue_ls: template/style; vtsls: TypeScript (hybrid mode); emmet/tailwindcss: template completions
    lsp = { "vue_ls", "vtsls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  go = {
    install = "system", -- managed with go install
    lsp = { "gopls" },
    linters = {},
    formatters = { "gofumpt" },
  },
  yaml = {
    install = "mason",
    lsp = { "yamlls" },
    linters = {},
    formatters = { "prettier" },
  },
  json = {
    install = "mason",
    lsp = { "jsonls" },
    linters = {},
    formatters = { "prettier" },
  },
  dockerfile = {
    install = "mason",
    lsp = { "docker_language_server" }, -- also covers compose files
    linters = { "hadolint" },
    formatters = {},
  },
  helm = {
    install = "mason",
    lsp = { "helm_ls" },
    linters = {},
    formatters = {},
  },
  ansible = {
    install = "mason",
    lsp = { "ansiblels" },
    linters = {}, -- ansiblels runs ansible-lint
    formatters = {},
    tools = { "ansible-lint" },
  },
  jinja = {
    install = "mason",
    lsp = { "jinja_lsp" },
    linters = {},
    formatters = {},
  },
  systemd = {
    install = "mason",
    lsp = { "systemd_lsp" }, -- podman quadlets
    linters = {},
    formatters = {},
  },
  sh = {
    install = "mason",
    lsp = { "bashls" },
    linters = {}, -- bashls runs shellcheck
    formatters = { "shfmt" },
    tools = { "shellcheck" },
  },
  markdown = {
    install = "mason",
    lsp = { "marksman" },
    linters = {},
    formatters = { "prettier" },
  },
  ruby = {
    install = "system", -- ruby-lsp and rubocop come from the project's bundle
    lsp = { "ruby_lsp" },
    linters = {}, -- rubocop via ruby_lsp
    formatters = {}, -- rubocop via ruby_lsp (lsp_format = "fallback")
  },
  toml = {
    install = "mason",
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
