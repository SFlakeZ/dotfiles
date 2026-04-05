
return {
  {
    -- Catppuccin: https://github.com/catppuccin/nvim
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
  {
    -- Tokyo Night: https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    opts = {},
    -- config = function()
    --   vim.cmd.colorscheme "tokyonight"
    -- end
  }
}

