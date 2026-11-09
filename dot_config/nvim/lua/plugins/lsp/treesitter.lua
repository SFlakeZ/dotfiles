local is_enabled = require("core.utils").is_enabled("treesitter")

-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  enabled = is_enabled,
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
      "markdown_inline",
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
      "ruby",
      "embedded_template",
      "helm",
      "jinja",
      "jinja_inline",
      "regex",
      "vimdoc",
      "query",
      "luadoc",
      "diff",
      "gitcommit",
      "git_rebase",
      "git_config",
      "gitignore",
    })

    -- the main branch does not start highlighting on its own
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
          return
        end
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
