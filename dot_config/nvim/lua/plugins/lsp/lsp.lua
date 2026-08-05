local lsp_servers = require("core.utils").lsp_servers()

-- nvim-lspconfig: https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        if client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })
    for _, server in ipairs(lsp_servers) do
      vim.lsp.enable(server)
    end
  end,
}
