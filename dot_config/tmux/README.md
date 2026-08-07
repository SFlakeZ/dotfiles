[← dotfiles](../../README.md)

# tmux Configuration

A lightweight tmux setup with vi-style navigation and a Catppuccin status
line.

## Structure

```
.
├── tmux.conf      general settings, keybindings, TPM bootstrap
└── plugins.conf   plugin list and plugin-specific configuration
```

## Requirements

- tmux >= 3.2 (for `focus-events` and `tmux-floax` popups)
- A [Nerd Font](https://www.nerdfonts.com/) installed in your *terminal* for
  the Catppuccin status line icons
- On macOS, `pbcopy`/`pbpaste` on `$PATH` for `tmux-yank`
- A UTF-8 locale (`LANG`/`LC_ALL`, e.g. `en_US.UTF-8`) — without one, glyph
  rendering (particularly Nerd Font icons) can come out broken; seen in
  practice on OpenBSD

## Plugin Manager

Plugins are managed using:

- [tpm](https://github.com/tmux-plugins/tpm)

`tmux.conf` bootstraps TPM automatically on first start if it isn't
installed yet. Install/update plugins afterwards with `prefix + I`.

## Plugins

| Plugin | Purpose |
|---|---|
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Status line theme |
| [tmux-floax](https://github.com/omerxx/tmux-floax) | Floating scratch pane/popup |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation between tmux and Neovim splits via `Ctrl-hjkl` |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save/restore session layouts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Automatic periodic saving and restore-on-start for tmux-resurrect |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copy to the system clipboard from copy-mode |

## Keymaps

Prefix is the default `Ctrl-b`.

| Keys | Action |
|---|---|
| `prefix h/j/k/l` | Select pane left/down/up/right |
| `Ctrl-h/j/k/l` | Navigate panes/splits, tmux- and Neovim-aware (vim-tmux-navigator) |
| `prefix H/J/K/L` | Resize pane left/down/up/right (repeatable) |
| `prefix r` | Reload `tmux.conf` |
| `prefix \|` | Split pane horizontally in the current path |
| `prefix -` | Split pane vertically in the current path |
| `prefix c` | New window in the current path |
| `v` / `y` (copy-mode-vi) | Begin selection / copy to system clipboard |
