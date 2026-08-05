return {
  -- Completion
  blink_cmp = { enabled = true },

  -- Formatting
  conform = { enabled = true },

  -- Linting
  nvim_lint = { enabled = true },

  -- Syntax highlighting
  -- Requirements: tar, curl, a C compiler, tree-sitter-cli (apt/cargo — not npm)
  treesitter = { enabled = true },

  -- UI
  lualine = { enabled = true },

  -- Utils
  autopairs = { enabled = true },
  gitsigns = { enabled = true },
  lazydev = { enabled = true },
  neo_tree = { enabled = true },
  render_markdown = { enabled = true },

  -- Requirements: ripgrep; fzf-native needs a C compiler + make (no fzf binary needed)
  telescope = { enabled = true },

  -- Requirements: git, curl/wget, unzip, tar/gtar, gzip
  mason = { enabled = true },
}
