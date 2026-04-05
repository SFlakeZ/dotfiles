
local utils = require("core.utils")

if utils.is_enabled("neo_tree") then
  vim.keymap.set("n", "<leader>n", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neotree filesystem", silent = true })
end

if utils.is_enabled("telescope") then
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files", silent = true })
  -- Requirements: ripgrep
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep", silent = true })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers", silent = true })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags", silent = true })
end

