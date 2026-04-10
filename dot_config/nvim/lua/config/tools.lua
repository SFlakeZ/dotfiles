local M = {}

-- LSP-Servers: <...>
-- Linters:     https://github.com/mfussenegger/nvim-lint
-- Formatters:  https://github.com/stevearc/conform.nvim

M.by_ft = {
	python = {
		mason_install = true,
		lsp = "ruff",
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
	javascript = {
		mason_install = true,
		lsp = "ts_ls",
		linters = { "eslint_d" },
		formatters = { "prettier" },
	},
	lua = {
		mason_install = true,
		lsp = "lua_ls",
		linters = {},
		formatters = { "stylua" },
	},
}

M.by_ft.cpp = M.by_ft.c

return M
