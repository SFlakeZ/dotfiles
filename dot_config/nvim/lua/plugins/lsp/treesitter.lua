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
    local install = require("nvim-treesitter").install(utils.treesitter_parsers())
    -- headless (no UI, e.g. a container build) waits, so 'nvim --headless +qa'
    -- does not quit before the parsers are built
    if #vim.api.nvim_list_uis() == 0 then
      install:wait(600000)
    end

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
