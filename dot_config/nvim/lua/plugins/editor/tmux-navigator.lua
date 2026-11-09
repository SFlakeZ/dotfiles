local is_enabled = require("core.utils").is_enabled("tmux_navigator")

-- vim-tmux-navigator: https://github.com/christoomey/vim-tmux-navigator
-- nvim side of the tmux plugin, keymaps are set in config/keymaps.lua
return {
  "christoomey/vim-tmux-navigator",
  enabled = is_enabled,
  cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
