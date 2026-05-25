local M = {}
local plugins = require("config.plugins")

function M.is_enabled(name)
  local plugin = plugins[name]
  if plugin == nil then
    return true
  end
  return plugin.enabled ~= false
end

local tools_by_ft = require("config.tools").by_ft

function M.lsp_servers()
  local added, result = {}, {}
  for _, cfg in pairs(tools_by_ft) do
    if cfg.lsp and not added[cfg.lsp] and cfg.mason_install then
      added[cfg.lsp] = true
      table.insert(result, cfg.lsp)
    end
  end
  return result
end

function M.linters_by_ft()
  local result = {}
  for ft, cfg in pairs(tools_by_ft) do
    if cfg.linters and #cfg.linters > 0 then
      result[ft] = cfg.linters
    end
  end
  return result
end

function M.formatters_by_ft()
  local result = {}
  for ft, cfg in pairs(tools_by_ft) do
    if cfg.formatters and #cfg.formatters > 0 then
      result[ft] = cfg.formatters
    end
  end
  return result
end

function M.mason_tools()
  local added, result = {}, {}
  for _, cfg in pairs(tools_by_ft) do
    if cfg.mason_install then
      for _, list in ipairs({ cfg.formatters or {}, cfg.linters or {} }) do
        for _, tool in ipairs(list) do
          local mason_pkg = M.mason_pkg_aliases[tool] or tool
          if not added[mason_pkg] then
            added[mason_pkg] = true
            table.insert(result, mason_pkg)
          end
        end
      end
    end
  end
  return result
end

-- Mason Aliases
M.mason_pkg_aliases = {
  ruff_format = "ruff",
}

return M
