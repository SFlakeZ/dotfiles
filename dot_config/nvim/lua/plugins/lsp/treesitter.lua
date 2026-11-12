local utils = require("core.utils")
local is_enabled = utils.is_enabled("treesitter")

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
    -- parsers the config uses everywhere (help, queries, git, markdown hover),
    -- the rest comes from the enabled languages in tools.lua
    require("nvim-treesitter").install(vim.list_extend({
      "lua",
      "luadoc",
      "vimdoc",
      "query",
      "regex",
      "markdown",
      "markdown_inline",
      "diff",
      "gitcommit",
      "git_rebase",
      "git_config",
      "gitignore",
    }, utils.treesitter_parsers()))

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
