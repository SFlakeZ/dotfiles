local utils = require("core.utils")

vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", { desc = "Remove search highlight", silent = true })

if utils.is_enabled("neo_tree") then
  vim.keymap.set(
    "n",
    "<leader>n",
    ":Neotree filesystem toggle left<CR>",
    { desc = "Toggle Neotree filesystem", silent = true }
  )
end

if utils.is_enabled("telescope") then
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files", silent = true })
  -- Requirements: ripgrep
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep", silent = true })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers", silent = true })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags", silent = true })

  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope go to word definition", silent = true })
  vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Telescope list lsp references", silent = true })
  vim.keymap.set(
    "n",
    "gi",
    builtin.lsp_implementations,
    { desc = "Telescope go to word implementation", silent = true }
  )
  vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Telescope go to type definition", silent = true })

  -- testing
  vim.keymap.set("n", "<leader>fm", function()
    local ft = vim.bo.filetype
    if ft == "c" or ft == "cpp" then
      builtin.man_pages({
        sections = { "2", "3", "7" },
      })
    else
      builtin.man_pages()
    end
  end, { desc = "Telescope list man pages", silent = true })
else
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
end
