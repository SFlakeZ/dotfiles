
return {
  -- Completion
  blink_cmp = { enabled = true },

  -- Formatting
  conform = { enabled = true },

  -- Linting
  nvim_lint = { enabled = true },

  -- Syntax highlighting
  -- Requirements: tar, curl, tree-sitter-cli
  treesitter = { enabled = true },

  -- UI
  lualine = { enabled = true },

  -- Utils
  neo_tree = { enabled = true },

  -- Requirements: ripgrep
  telescope = { enabled = true },

  -- Requirements: git, curl/wget, unzip, tar/gtar, gzip
  mason = { enabled = true, auto_install = true }
}

