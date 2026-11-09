local utils = require("core.utils")

vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight" })

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

  -- grr/gri/grt replace the neovim defaults, a plain gr would wait for timeoutlen
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope go to word definition", silent = true })
  vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Telescope list lsp references", silent = true })
  vim.keymap.set(
    "n",
    "gri",
    builtin.lsp_implementations,
    { desc = "Telescope go to word implementation", silent = true }
  )
  vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { desc = "Telescope go to type definition", silent = true })
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
  -- grr/gri/grt are neovim defaults
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
end

-- Toggles
vim.keymap.set("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end, { desc = "Toggle inlay hints" })

local virtual_text = vim.diagnostic.config().virtual_text
vim.keymap.set("n", "<leader>ud", function()
  local enabled = vim.diagnostic.config().virtual_text ~= false
  vim.diagnostic.config({ virtual_text = not enabled and virtual_text or false })
end, { desc = "Toggle inline diagnostics" })

if utils.is_enabled("conform") then
  vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<CR>", { desc = "Toggle format on save" })
  vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle!<CR>", { desc = "Toggle format on save (buffer)" })
end

if utils.is_enabled("nvim_lint") then
  vim.keymap.set("n", "<leader>ul", "<cmd>LintToggle<CR>", { desc = "Toggle lint on save" })
  vim.keymap.set("n", "<leader>cl", "<cmd>Lint<CR>", { desc = "Lint buffer" })
end

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Show diagnostic float" })

-- Code
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

if utils.is_enabled("conform") then
  vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "Format buffer/selection" })
end
