-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
  config = function()
    require("nvim-treesitter").setup({
      -- Directory to install parsers and queries to
      -- (prepend to 'runtimepath' to have priority)
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install({
      "lua",
      "perl",
      "python",
      "rust",
      "c",
      "cpp",
      "make",
      "json",
      "yaml",
      "toml",
      "markdown",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "java",
      "kotlin",
      "dockerfile",
      "go",
      "bash",
      "gitcommit",
    })
  end,
}
