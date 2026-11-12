local is_enabled = require("core.utils").is_enabled("mason")
local lsp_servers = require("core.utils").mason_lsp_servers()
local tools = require("core.utils").mason_tools()

return {
  {
    -- mason: https://github.com/mason-org/mason.nvim
    "mason-org/mason.nvim",
    enabled = is_enabled,
    opts = {},
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    -- mason-lspconfig: https://github.com/mason-org/mason-lspconfig.nvim
    "mason-org/mason-lspconfig.nvim",
    enabled = is_enabled,
    opts = {
      -- servers are installed by mason-tool-installer and enabled in lsp.lua
      -- from tools.lua, not everything installed
      automatic_enable = false,
    },
  },
  {
    -- mason-tool-installer: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = is_enabled,
    -- lsp servers by their lspconfig names (mason-lspconfig integration), so
    -- :MasonToolsInstallSync installs everything, e.g. in a headless bootstrap
    opts = {
      ensure_installed = vim.list_extend(vim.list_extend({}, lsp_servers), tools),
    },
  },
}
