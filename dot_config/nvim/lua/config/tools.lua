local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim
--
-- 'lsp' is a list, some filetypes need several clients (e.g. vue)
-- 'tools' are extra mason packages an lsp calls on its own (e.g. shellcheck)
-- 'install' is who installs the tools: "mason", or "system" for a package
-- manager, rustup, go install, ... (lsp, linters and formatters are used either way)
-- 'parsers' are the treesitter parsers, names differ from filetypes (sh -> bash)

M.by_ft = {
  python = {
    install = "mason",
    parsers = { "python" },
    lsp = { "basedpyright" }, -- "ruff", "pyright"
    linters = {}, -- provided by lsp
    formatters = { "ruff_format" },
  },
  perl = {
    install = "system",
    parsers = { "perl" },
    lsp = { "perlnavigator" },
    linters = {},
    formatters = {},
  },
  c = {
    install = "mason",
    parsers = { "c", "cpp", "make" },
    lsp = { "clangd" },
    linters = {},
    formatters = { "clang-format" },
  },
  lua = {
    install = "mason",
    parsers = {}, -- see M.base_parsers
    lsp = { "lua_ls" },
    linters = {},
    formatters = { "stylua" },
  },
  rust = {
    install = "system", -- managed with rustup
    parsers = { "rust" },
    lsp = { "rust_analyzer" },
    linters = {},
    formatters = { "rustfmt" },
  },
  html = {
    install = "mason",
    parsers = { "html" },
    lsp = { "html", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  css = {
    install = "mason",
    parsers = { "css" },
    lsp = { "cssls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  javascript = {
    install = "mason",
    parsers = { "javascript", "typescript", "tsx" },
    lsp = { "vtsls" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  java = {
    install = "mason",
    parsers = { "java" },
    lsp = { "jdtls" },
    linters = {}, -- provided by lsp
    formatters = { "google-java-format" },
  },
  kotlin = {
    install = "mason",
    parsers = { "kotlin" },
    lsp = { "kotlin_lsp" },
    linters = {}, -- provided by lsp
    formatters = { "ktlint" },
  },
  vue = {
    install = "mason",
    parsers = { "vue", "typescript", "html", "css" },
    -- vue_ls: template/style; vtsls: TypeScript (hybrid mode); emmet/tailwindcss: template completions
    lsp = { "vue_ls", "vtsls", "emmet_language_server", "tailwindcss" },
    linters = { "eslint_d" },
    formatters = { "prettier" },
  },
  go = {
    install = "system", -- managed with go install
    parsers = { "go" },
    lsp = { "gopls" },
    linters = {},
    formatters = { "gofumpt" },
  },
  yaml = {
    install = "mason",
    parsers = { "yaml" },
    lsp = { "yamlls" },
    linters = {},
    formatters = { "prettier" },
  },
  json = {
    install = "mason",
    parsers = { "json" },
    lsp = { "jsonls" },
    linters = {},
    formatters = { "prettier" },
  },
  dockerfile = {
    install = "mason",
    parsers = { "dockerfile" },
    lsp = { "docker_language_server" }, -- also covers compose files
    linters = { "hadolint" },
    formatters = {},
  },
  helm = {
    install = "mason",
    parsers = { "helm", "yaml" },
    lsp = { "helm_ls" },
    linters = {},
    formatters = {},
  },
  ansible = {
    install = "mason",
    parsers = { "yaml", "jinja", "jinja_inline" },
    lsp = { "ansiblels" },
    linters = {}, -- ansiblels runs ansible-lint
    formatters = {},
    tools = { "ansible-lint" },
  },
  jinja = {
    install = "mason",
    parsers = { "jinja", "jinja_inline" },
    lsp = { "jinja_lsp" },
    linters = {},
    formatters = {},
  },
  systemd = {
    install = "mason",
    parsers = {},
    lsp = { "systemd_lsp" }, -- podman quadlets
    linters = {},
    formatters = {},
  },
  sh = {
    install = "mason",
    parsers = { "bash" },
    lsp = { "bashls" },
    linters = {}, -- bashls runs shellcheck
    formatters = { "shfmt" },
    tools = { "shellcheck" },
  },
  markdown = {
    install = "mason",
    parsers = {}, -- see M.base_parsers
    lsp = { "marksman" },
    linters = {},
    formatters = { "prettier" },
  },
  ruby = {
    install = "system", -- ruby-lsp and rubocop come from the project's bundle
    parsers = { "ruby", "embedded_template" },
    lsp = { "ruby_lsp" },
    linters = {}, -- rubocop via ruby_lsp
    formatters = {}, -- rubocop via ruby_lsp (lsp_format = "fallback")
  },
  toml = {
    install = "mason",
    parsers = { "toml" },
    lsp = { "taplo" },
    linters = {},
    formatters = {}, -- taplo formats via LSP (conform lsp_format = "fallback")
  },
}

-- Treesitter parsers the config uses everywhere (help, queries, git, markdown
-- hover), installed regardless of the enabled languages
M.base_parsers = {
  "lua",
  "luadoc",
  "vimdoc",
  "query",
  "regex",
  "markdown",
  "markdown_inline",
  "diff",
  "gitcommit",
  "git_rebase",
  "git_config",
  "gitignore",
}

M.by_ft.cpp = M.by_ft.c
M.by_ft.typescript = M.by_ft.javascript
M.by_ft.javascriptreact = M.by_ft.javascript
M.by_ft.typescriptreact = M.by_ft.javascript

return M
