# Dotfiles

My dotfiles are managed with [chezmoi](https://github.com/twpayne/chezmoi)!

### Currently included:
- `.chezmoiignore` to ignore files that should not be applied using `chezmoi apply`
- [git](https://git-scm.com) configuration
- [nvim](./dot_config/nvim/README.md)

### Structure:

```
.
├── .chezmoiignore
├── dot_config
│   ├── git
│   │   ├── aliases
│   │   ├── config.tmpl
│   │   ├── ignore
│   │   └── message
│   └─── nvim
└── README.md
```

### Templating

A [template in chezmoi](https://www.chezmoi.io/user-guide/templating/) allows us to use variables and functions<br>
to modify file content based on variables in `chezmoi data`.

For Git, the following variables are required in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    git_user_email = "<email>"
    git_user_name = "<name>"
```

