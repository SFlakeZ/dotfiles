local lsp_servers = require("core.utils").lsp_servers()

-- nvim-lspconfig: https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  config = function()
    for _, server in ipairs(lsp_servers) do
      vim.lsp.enable(server)
    end
  end,
}
