-- See ':help mapleader'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load lazy.nvim
require("core.lazy")

-- Load general configuration
require("config.options")
require("config.filetypes")

-- Load keymaps
require("config.keymaps")
