local utils = require("core.utils")
local lsp_servers = utils.lsp_servers()
local mason_servers = utils.mason_lsp_servers()

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

    -- servers not installed by mason (ruby_lsp, gopls, ...) are skipped when
    -- missing, otherwise every matching buffer shows a spawn error.
    -- Servers with a function as cmd need their binary listed here.
    local executables = { ruby_lsp = "ruby-lsp" }
    for _, server in ipairs(lsp_servers) do
      local cmd = vim.lsp.config[server] and vim.lsp.config[server].cmd
      local bin = executables[server] or (type(cmd) == "table" and cmd[1])
      local missing = bin and vim.fn.executable(bin) == 0
      if vim.tbl_contains(mason_servers, server) or not missing then
        vim.lsp.enable(server)
      end
    end
  end,
}
