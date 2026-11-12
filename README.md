# Dotfiles

My dotfiles are managed with [chezmoi](https://github.com/twpayne/chezmoi)!

### Currently included:
- [git](https://git-scm.com) configuration
- [nvim](./dot_config/nvim/README.md) configuration
- [tmux](./dot_config/tmux/README.md) configuration
- [aerospace](https://github.com/nikitabobko/AeroSpace) configuration (macOS only)
- [zed](https://zed.dev) settings (not in a pack yet)

### Setup

```sh
chezmoi init --apply SFlakeZ/dotfiles
```

`chezmoi init` asks once for the git user and a pack and writes the answers to
`~/.config/chezmoi/chezmoi.toml`, they are never part of this repo. Without a
terminal, answer the prompts with flags (the key is the prompt text):

```sh
chezmoi init --apply \
  --promptString "Git user name=<name>" \
  --promptString "Git user email=<email>" \
  --promptChoice "Pack=minimal" \
  SFlakeZ/dotfiles
```

Run `chezmoi init` again after this repo changes `.chezmoi.toml.tmpl`.

### Packs

Defined in [.chezmoidata/packs.toml](./.chezmoidata/packs.toml):

| Pack | Components | nvim languages |
|---|---|---|
| `minimal` | git, tmux, nvim | none |
| `standard` | git, tmux, nvim, aerospace | lua |

A component is only applied if its tools are installed, otherwise
`chezmoi apply` prints a warning:

| Component | Requires |
|---|---|
| git | `git` |
| tmux | `tmux` |
| nvim | `nvim`, `tree-sitter` |
| aerospace | macOS, `aerospace` |
| zed | `zed` or `zeditor` |

Per machine overrides in `~/.config/chezmoi/chezmoi.toml`, kept on re-init:

```toml
[data]
    pack = "standard"
    extra = ["zed"]                            # components on top of the pack
    skip = ["tmux"]                            # components to leave out
    nvim_languages = ["lua", "python", "sh"]   # replaces the pack's languages
```

Available nvim languages are listed in
[lua/config/README.md](./dot_config/nvim/lua/config/README.md#toolslua).

chezmoi does not delete files that become ignored, remove them by hand.

### Checking what gets applied

```sh
chezmoi ignored                                  # targets left out on this machine
chezmoi execute-template < .chezmoiignore        # rendered ignore file with reasons
chezmoi diff                                     # what apply would change
chezmoi data | jq '{pack, extra, skip, nvim_languages}'
```

### Structure:

```
.
├── .chezmoi.toml.tmpl                   prompts for ~/.config/chezmoi/chezmoi.toml
├── .chezmoidata
│   └── packs.toml                       packs and component requirements
├── .chezmoiignore                       skips components (see packs.toml)
├── .chezmoitemplates
│   └── skipped-components               shared skip logic
├── run_after_check-requirements.sh.tmpl warns about missing tools
├── dot_config
│   ├── aerospace
│   ├── git
│   │   ├── aliases
│   │   ├── config.tmpl
│   │   ├── ignore
│   │   └── message
│   ├── nvim
│   ├── tmux
│   └── zed
└── README.md
```

### Templating

A [template in chezmoi](https://www.chezmoi.io/user-guide/templating/) allows us to use variables and functions<br>
to modify file content based on variables in `chezmoi data`. The git config uses
`git_user_name` and `git_user_email`, nvim's `lua/config/languages.lua` uses
`nvim_languages`.
