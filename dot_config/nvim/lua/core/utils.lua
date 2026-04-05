
local M = {}
local plugins = require("config.plugins")

function M.is_enabled(name)
  local plugin = plugins[name]
  if plugin == nil then
    return true
  end
  return plugin.enabled ~= false
end

return M

