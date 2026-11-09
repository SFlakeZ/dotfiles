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

-- C-hjkl moves across nvim splits and tmux panes
if utils.is_enabled("tmux_navigator") then
  vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Split/pane left" })
  vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Split/pane down" })
  vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Split/pane up" })
  vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Split/pane right" })
end

if utils.is_enabled("telescope") then
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files", silent = true })
  -- Requirements: ripgrep
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep", silent = true })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers", silent = true })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags", silent = true })
  vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Telescope grep word under cursor", silent = true })
  vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope recent files", silent = true })
  vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume last picker", silent = true })
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics", silent = true })
  vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps", silent = true })
  vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Telescope git status", silent = true })
  vim.keymap.set("n", "<leader>fc", builtin.git_bcommits, { desc = "Telescope buffer commits", silent = true })

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

if utils.is_enabled("gitsigns") then
  local gitsigns = require("gitsigns")

  -- in diff mode ]c/[c keep their builtin meaning
  vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, { desc = "Next git hunk" })
  vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, { desc = "Previous git hunk" })

  vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage/unstage hunk" })
  vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
  vim.keymap.set("v", "<leader>gs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage/unstage selection" })
  vim.keymap.set("v", "<leader>gr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset selection" })
  vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
  vim.keymap.set("n", "<leader>gb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Blame line" })
  vim.keymap.set("n", "<leader>gB", gitsigns.blame, { desc = "Blame buffer" })
  vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff against index" })
  vim.keymap.set("n", "<leader>gq", function()
    gitsigns.setqflist("all")
  end, { desc = "All hunks to quickfix" })
  vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select git hunk" })
  vim.keymap.set("n", "<leader>ub", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
end

if utils.is_enabled("diffview") then
  vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewToggle<CR>", { desc = "Toggle diffview" })
  vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
  vim.keymap.set("v", "<leader>gh", ":DiffviewFileHistory<CR>", { desc = "Selection history" })
  vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Branch history" })
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
