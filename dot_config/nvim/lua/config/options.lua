-- General
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.o.winborder = "rounded" -- possible values: single, double, solid, shadow, none

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.diagnostic.config({
  virtual_text = { prefix = "󰜵", spacing = 2 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "", -- replaces "E"
      [vim.diagnostic.severity.WARN] = "", -- replaces "W"
      [vim.diagnostic.severity.HINT] = "", -- replaces "H"
      [vim.diagnostic.severity.INFO] = "", -- replaces "I"
    },
  },
  float = { border = "rounded" },
})
