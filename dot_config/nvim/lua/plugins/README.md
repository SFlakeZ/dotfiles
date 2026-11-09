[← nvim](../../README.md)

# lua/plugins

Plugin specs for [lazy.nvim](https://github.com/folke/lazy.nvim), grouped
into three categories. Each file returns exactly one plugin spec (see the
[mason.lua exception](#lsp) below), and each spec reads its own
enabled/disabled flag from [config/plugins.lua](../config/README.md#pluginslua)
via `require("core.utils").is_enabled("<name>")`.

- **lsp**: language servers, completion, formatting, linting,
  treesitter, tool installation
- **editor**: file explorer, fuzzy finder, editing QoL, git
- **ui**: colorscheme, statusline, keymap hints

## lsp

| File | Plugin | Purpose |
|---|---|---|
| `completion.lua` | [blink.cmp](https://github.com/saghen/blink.cmp) (+ [LuaSnip](https://github.com/L3MON4D3/LuaSnip), [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)) | Autocompletion engine and snippet expansion |
| `formatting.lua` | [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting with formatters from `tools.lua`, format on save opt-in |
| `linting.lua` | [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting on buffer write, toggleable |
| `lsp.lua` | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Enables LSP servers from `tools.lua`, inlay hints on attach |
| `mason.lua` | [mason.nvim](https://github.com/mason-org/mason.nvim), [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim), [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Installs/manages LSP servers, linters and formatters |
| `treesitter.lua` | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and indentation |
| `lazydev.lua` | [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Neovim API type annotations, loads on `lua` files only |

`mason.lua` is the one exception to the one-file-one-plugin rule: it
groups mason.nvim, mason-lspconfig.nvim and mason-tool-installer.nvim
in a single file.

## editor

| File | Plugin | Purpose |
|---|---|---|
| `neo-tree.lua` | [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) (+ plenary.nvim, nui.nvim, nvim-web-devicons) | File explorer sidebar |
| `telescope.lua` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (+ plenary.nvim, telescope-fzf-native.nvim) | Fuzzy finder for files, grep, buffers, LSP results |
| `autopairs.lua` | [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes brackets and quotes |
| `gitsigns.lua` | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Hunk signs, staging, preview and blame |
| `diffview.lua` | [diffview-plus.nvim](https://github.com/dlyongemallo/diffview-plus.nvim) | Review all changes, merge conflicts, file and branch history |
| `tmux-navigator.lua` | [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | `C-hjkl` across nvim splits and tmux panes |
| `render-markdown.lua` | [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-buffer rendered markdown preview |

## ui

| File | Plugin | Purpose |
|---|---|---|
| `colorscheme.lua` | [catppuccin/nvim](https://github.com/catppuccin/nvim) | Colorscheme (`catppuccin-mocha`) |
| `lualine.lua` | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (+ nvim-web-devicons) | Statusline, shows when format on save is on |
| `which-key.lua` | [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup with available keymaps |
