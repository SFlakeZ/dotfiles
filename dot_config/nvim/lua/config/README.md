[← nvim](../../README.md)

# lua/config

Non-plugin-manager configuration: editor options, keymaps, the plugin
enable/disable switchboard, and the per-language tooling registry.

## options.lua

Editor settings: line numbers (relative + absolute), cursorline, rounded
window borders, case-insensitive/smart search, 2-space indentation by
default with per-filetype overrides (4 spaces for `c`, `cpp`, `python`,
`rust`, `toml`; tabs for `go`, `make`), and diagnostic display (custom
signs, virtual text, rounded floating windows).

## keymaps.lua

All custom keybindings live here. Nothing plugin-specific is bound
outside this file. Keymaps gated behind a plugin flag only apply when
that plugin is enabled in [plugins.lua](#pluginslua).

| Mode | Keys | Action | Requires |
|---|---|---|---|
| n | `<ESC>` | Clear search highlight | — |
| n | `<leader>n` | Toggle Neo-tree (filesystem, left) | `neo_tree` |
| n | `<leader>ff` | Find files | `telescope` |
| n | `<leader>fg` | Live grep (needs [ripgrep](https://github.com/BurntSushi/ripgrep)) | `telescope` |
| n | `<leader>fb` | List open buffers | `telescope` |
| n | `<leader>fh` | Search help tags | `telescope` |
| n | `<leader>fm` | List man pages (sections 2/3/7 for C/C++) | `telescope` |
| n | `gd` | Go to definition | LSP always; via Telescope if `telescope` enabled |
| n | `gr` | List references | LSP always; via Telescope if `telescope` enabled |
| n | `gi` | Go to implementation | LSP always; via Telescope if `telescope` enabled |
| n | `gy` | Go to type definition | LSP always; via Telescope if `telescope` enabled |
| n | `<leader>h` | Toggle inlay hints | — |
| n | `<leader>ca` | Code actions | — |
| n, v | `<leader>cf` | Format buffer/selection | `conform` |

Plugin-internal default keymaps (e.g. blink.cmp's completion menu, or
Neo-tree's in-buffer navigation) are intentionally **not** documented
here. They're covered by the plugin's own docs, linked from
[lua/plugins/README.md](../plugins/README.md); basic Vim/Neovim
knowledge is assumed.

## plugins.lua

A flat enable/disable switchboard, keyed by an internal short name (e.g.
`telescope`, `mason`, `gitsigns`):

```lua
return {
  telescope = { enabled = true },
  -- ...
}
```

Every plugin spec and every gated keymap reads its flag via
`require("core.utils").is_enabled("<name>")`. A plugin is treated as
enabled if it's missing from this table entirely, so an entry is only
needed to turn something *off*.

## tools.lua

The single source of truth for per-language tooling, consumed by
`lsp.lua`, `formatting.lua`, `linting.lua` and `mason.lua` via helpers in
`core/utils.lua`.

| Filetype | LSP | Linters | Formatters | Mason-installed |
|---|---|---|---|---|
| python | basedpyright | — | ruff_format | yes |
| lua | lua_ls | — | stylua | yes |
| perl | perlnavigator | — | — | no |
| rust | rust_analyzer | — | rustfmt | no (rustup) |
| go | gopls | — | gofumpt | no (go install) |
| html | html | eslint_d | prettier | yes |
| css | cssls | eslint_d | prettier | yes |
| javascript | ts_ls | eslint_d | prettier | yes |
| typescript | ts_ls | eslint_d | prettier | yes |
| vue | vue_ls | eslint_d | prettier | yes |
| yaml | yamlls | — | prettier | yes |
| json | jsonls | — | prettier | yes |
| dockerfile | dockerls | — | — | yes |
| sh | bashls | — | shfmt | yes |
| c | clangd | — | clang-format | yes |
| cpp | clangd | — | clang-format | yes |

`typescript` aliases the `javascript` entry and `cpp` aliases the `c`
entry (same LSP/linter/formatter config).
