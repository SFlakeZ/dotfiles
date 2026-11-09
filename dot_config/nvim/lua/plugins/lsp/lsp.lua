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

    -- vue_ls only handles template/style, vtsls provides typescript in .vue
    -- https://github.com/vuejs/language-tools/wiki/Neovim
    local vue_language_server_path = vim.fn.stdpath("data")
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
    if vim.uv.fs_stat(vue_language_server_path) then
      vim.lsp.config("vtsls", {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_language_server_path,
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },
      })
    end

    -- kubernetes schema for manifests in the usual folders, other files can
    -- use a modeline: # yaml-language-server: $schema=<url>
    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemas = {
            kubernetes = {
              "k8s/**/*.yaml",
              "k8s/**/*.yml",
              "kubernetes/**/*.yaml",
              "kubernetes/**/*.yml",
              "manifests/**/*.yaml",
              "manifests/**/*.yml",
              "*.k8s.yaml",
              "*.k8s.yml",
            },
          },
        },
      },
    })

    -- clippy instead of cargo check
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          check = { command = "clippy" },
        },
      },
    })

    for _, server in ipairs(lsp_servers) do
      vim.lsp.enable(server)
    end
  end,
}
