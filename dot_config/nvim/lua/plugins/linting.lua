
local is_enabled = require("core.utils").is_enabled("nvim_lint")
local linters = require("core.utils").linters_by_ft()

-- nvim-lint: https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  opts = {},
  enabled = is_enabled,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = linters

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- 'try_lint' without arguments runs the linters defined in 'linters_by_ft'
        -- for the current filetype
        lint.try_lint()

        -- You can call 'try_lint' with a linter name or a list of names to always
        -- run specific linters, independet of the 'linters_by_ft' configuration
        -- require("lint").try_lint("cspell")
      end
    })
  end
}

