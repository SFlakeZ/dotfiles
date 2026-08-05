[← dotfiles](../README.md)

# Neovim Configuration

An opinionated modular Neovim setup.

## Structure

```
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── core                 bootstrap: lazy.nvim setup, shared helpers
    │   ├── lazy.lua
    │   └── utils.lua
    ├── config               → see lua/config/README.md
    │   ├── keymaps.lua
    │   ├── options.lua
    │   ├── plugins.lua
    │   └── tools.lua
    └── plugins               → see lua/plugins/README.md
        ├── lsp               language servers, completion, formatting, linting, treesitter
        ├── editor             file explorer, fuzzy finder, editing QoL, git signs
        └── ui                colorscheme, statusline
```

`init.lua` sets the leader key, then loads `core.lazy` (plugin manager
bootstrap), `config.options` (editor settings) and `config.keymaps`
(keybindings), in that order.

## Requirements

### Neovim

- Neovim >= 0.12
- On Ubuntu, the apt package is usually too old — use the
  [neovim-ppa/unstable](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable)
  PPA or the official release tarball from
  [neovim/neovim releases](https://github.com/neovim/neovim/releases).

### System dependencies

Verified against the requirements listed by each plugin's own docs
(mason.nvim, nvim-treesitter, telescope-fzf-native.nvim), not just
inferred from this repo's comments — kept here so the setup is
reproducible (e.g. in a devcontainer).

| Tool | Needed for | Ubuntu package(s) |
|---|---|---|
| git, curl, unzip, tar, gzip | lazy.nvim bootstrap, Mason & Treesitter downloads (also mason.nvim's own requirements) | `git curl unzip tar gzip` |
| C compiler + make | Treesitter parser builds (`:TSUpdate`), telescope-fzf-native.nvim build — **no `fzf` binary needed** | `build-essential` |
| ripgrep | Telescope `live_grep` | `ripgrep` |
| tree-sitter-cli | Building Treesitter parsers without a committed `parser.c` — install via a package manager, **not npm** | `tree-sitter-cli` (Ubuntu ≥ 24.04) or `cargo install --locked tree-sitter-cli` |
| man-db, manpages-dev | `<leader>fm` (Telescope man pages) | `man-db manpages-dev` |
| Node.js + npm | Most Mason packages: html, cssls, ts_ls, vue_ls, eslint_d, prettier, yamlls, jsonls, dockerls, bashls, basedpyright, perlnavigator | via [NodeSource](https://github.com/nodesource/distributions) or nvm — not the outdated apt package |
| Python3 + pip/pipx | `clang-format` (Mason package) | `python3 python3-pip pipx` |
| Go toolchain | `gopls`, `gofumpt` — managed with `go install`, not Mason (see [tools.lua](./lua/config/tools.lua)) | official [Go tarball](https://go.dev/dl/) |
| Rust toolchain (rustup) | `rust_analyzer`, `rustfmt` — managed with rustup, not Mason | [rustup.rs](https://rustup.rs) |

Optional: a [Nerd Font](https://www.nerdfonts.com/) installed in your
*terminal* (not the container) for the icons used by lualine and
nvim-web-devicons.

## Plugin Manager

Plugins are managed using:

- [lazy.nvim](https://github.com/folke/lazy.nvim)

Locked plugin versions are stored in [lazy-lock.json](./lazy-lock.json).<br>
Plugins can be enabled or disabled in [plugins.lua](./lua/config/plugins.lua).

See [lua/plugins/README.md](./lua/plugins/README.md) for the full plugin
catalog.

## Language Tooling

Language servers, linters and formatters can be installed with:

- [mason.nvim](https://github.com/mason-org/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)

Mason's own requirements (git, curl/wget, unzip, tar/gtar, gzip) are
covered by the [System dependencies](#system-dependencies) table above.

If mason is disabled, language servers, linters and formatters can still be added
in [tools.lua](./lua/config/tools.lua). [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
provides configurations. Blink.cmp handles completion and conform formatting.

See [lua/config/README.md](./lua/config/README.md#toolslua) for the full
list of currently configured languages.

## Keymaps

All custom keybindings live in a single file,
[keymaps.lua](./lua/config/keymaps.lua). See
[lua/config/README.md](./lua/config/README.md#keymapslua) for the full
table. Plugin-internal default keymaps (e.g. blink.cmp's completion menu)
are not documented here — check the plugin's own repo, linked from
[lua/plugins/README.md](./lua/plugins/README.md).

## See also

- [lua/config/README.md](./lua/config/README.md) — options, keymaps, the
  plugin toggle system and the per-language tooling table
- [lua/plugins/README.md](./lua/plugins/README.md) — plugin catalog by
  category, with links to every upstream repo

