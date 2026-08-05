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

-- Appends 'value' to 'result' the first time it is seen, tracked via 'seen'.
local function add_unique(result, seen, value)
  if not seen[value] then
    seen[value] = true
    table.insert(result, value)
  end
end

-- Unique 'lsp' values across tools_by_ft, optionally restricted by 'filter(cfg)'.
local function collect_lsp_servers(filter)
  local seen, result = {}, {}
  for _, cfg in pairs(tools_by_ft) do
    if cfg.lsp and (not filter or filter(cfg)) then
      add_unique(result, seen, cfg.lsp)
    end
  end
  return result
end

-- Maps filetype -> list from tools_by_ft[ft][field] (e.g. 'linters'/'formatters').
local function collect_by_ft(field)
  local result = {}
  for ft, cfg in pairs(tools_by_ft) do
    local list = cfg[field]
    if list and #list > 0 then
      result[ft] = list
    end
  end
  return result
end

function M.mason_lsp_servers()
  return collect_lsp_servers(function(cfg)
    return cfg.mason_install
  end)
end

function M.lsp_servers()
  return collect_lsp_servers()
end

function M.linters_by_ft()
  return collect_by_ft("linters")
end

function M.formatters_by_ft()
  return collect_by_ft("formatters")
end

function M.mason_tools()
  local seen, result = {}, {}
  for _, cfg in pairs(tools_by_ft) do
    if cfg.mason_install then
      for _, list in ipairs({ cfg.formatters or {}, cfg.linters or {} }) do
        for _, tool in ipairs(list) do
          add_unique(result, seen, M.mason_pkg_aliases[tool] or tool)
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
