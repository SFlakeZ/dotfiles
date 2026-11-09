local utils = require("core.utils")
local is_enabled = utils.is_enabled("nvim_lint")
local linters = utils.linters_by_ft()

-- nvim-lint: https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  opts = {},
  enabled = is_enabled,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = linters
    vim.g.lint_on_save = utils.option("nvim_lint", "lint_on_save", true)

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        if vim.g.lint_on_save then
          -- runs the linters defined in 'linters_by_ft' for the current filetype
          lint.try_lint()
        end
      end,
    })

    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, { desc = "Lint current buffer" })

    vim.api.nvim_create_user_command("LintToggle", function()
      vim.g.lint_on_save = not vim.g.lint_on_save
      if not vim.g.lint_on_save then
        for _, names in pairs(lint.linters_by_ft) do
          for _, name in ipairs(names) do
            vim.diagnostic.reset(lint.get_namespace(name))
          end
        end
      end
      vim.notify("Lint on save " .. (vim.g.lint_on_save and "on" or "off"))
    end, { desc = "Toggle lint on save" })
  end,
}
