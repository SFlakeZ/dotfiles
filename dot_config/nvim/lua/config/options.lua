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
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- 4 space languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "python", "rust", "toml" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Tab-based languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "make" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.opt.signcolumn = "yes" -- prevents layout shift

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
