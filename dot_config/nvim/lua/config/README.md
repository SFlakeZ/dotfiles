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

Inline diagnostics (virtual text) are on by default; flip the
`diagnostics_virtual_text` local at the top of the `vim.diagnostic.config()`
call to `false` if you'd rather rely on signs + the floating window only
(can also be toggled at runtime, see `<leader>d` below). `]d`/`[d`
additionally auto-open the diagnostic float after jumping (via
`jump.on_jump`), same idea as hovering with `K`.

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
| n | `<leader>d` | Toggle inline diagnostics (virtual text) | — |
| n | `<leader>e` | Show diagnostic float | — |
| n | `<leader>ca` | Code actions | — |
| n, v | `<leader>cf` | Format buffer/selection | `conform` |

Plugin-internal default keymaps (e.g. blink.cmp's completion menu, or
Neo-tree's in-buffer navigation) are intentionally **not** documented
here. They're covered by the plugin's own docs, linked from
[lua/plugins/README.md](../plugins/README.md); basic Vim/Neovim
knowledge is assumed.

Neovim's own default mappings (see `:h vim.lsp.buf` and `:h ]d-default`)
are **not** redefined here either, but are worth knowing about since they
cover diagnostics directly:

| Keys | Action |
|---|---|
| `]d` / `[d` | Jump to next/previous diagnostic (auto-opens the float, see `options.lua`) |
| `]D` / `[D` | Jump to last/first diagnostic |
| `<C-w>d` | Show the diagnostic under the cursor in a floating window (prefix key: press+release `<C-w>`, *then* `d` without Ctrl — not a chord; use `<leader>e` above if that's confusing) |

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
`core/utils.lua`. `lsp` is a list — most filetypes need exactly one server,
but a filetype can declare several LSP clients that attach to the same
buffer (see `vue` below).

| Filetype | LSP | Linters | Formatters | Mason-installed |
|---|---|---|---|---|
| python | basedpyright | — | ruff_format | yes |
| lua | lua_ls | — | stylua | yes |
| perl | perlnavigator | — | — | no |
| rust | rust_analyzer | — | rustfmt | no (rustup) |
| go | gopls | — | gofumpt | no (go install) |
| html | html, emmet_language_server, tailwindcss | eslint_d | prettier | yes |
| css | cssls, emmet_language_server, tailwindcss | eslint_d | prettier | yes |
| javascript | vtsls | eslint_d | prettier | yes |
| typescript | vtsls | eslint_d | prettier | yes |
| vue | vue_ls, vtsls, emmet_language_server, tailwindcss | eslint_d | prettier | yes |
| java | jdtls | — | google-java-format | yes |
| kotlin | kotlin_lsp | — | ktlint | yes |
| yaml | yamlls | — | prettier | yes |
| json | jsonls | — | prettier | yes |
| toml | taplo | — | — (via LSP) | yes |
| dockerfile | dockerls | — | — | yes |
| sh | bashls | — | shfmt | yes |
| c | clangd | — | clang-format | yes |
| cpp | clangd | — | clang-format | yes |

`typescript` aliases the `javascript` entry and `cpp` aliases the `c`
entry (same LSP/linter/formatter config).

`vue` needs several LSP clients on the same buffer: `vue_ls` only handles
templates/styles in its "hybrid mode", so `vtsls` (with the
`@vue/typescript-plugin`, wired up in `lsp.lua`) provides TypeScript
support — hover, diagnostics, go-to-definition — inside `.vue` files.
`emmet_language_server` adds Emmet abbreviation expansion and
`tailwindcss` adds Tailwind class completion/hover; both also attach to
`html`/`css` for the same reason. See
https://github.com/vuejs/language-tools/wiki/Neovim.

`rust_analyzer` is configured (in `lsp.lua`) to run Clippy instead of plain
`cargo check` for diagnostics on save (`rust-analyzer.check.command`).

`toml` has no dedicated formatter entry — `taplo` provides formatting via
its own LSP implementation, picked up by conform's `lsp_format = "fallback"`.
