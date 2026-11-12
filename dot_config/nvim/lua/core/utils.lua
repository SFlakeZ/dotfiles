local M = {}
local plugins = require("config.plugins")

function M.is_enabled(name)
  local plugin = plugins[name]
  if plugin == nil then
    return true
  end
  return plugin.enabled ~= false
end

-- Value of 'key' for 'name' in config/plugins.lua, 'default' if unset.
function M.option(name, key, default)
  local plugin = plugins[name]
  if plugin == nil or plugin[key] == nil then
    return default
  end
  return plugin[key]
end

-- Buffer setting wins over the global one (see :FormatToggle).
function M.autoformat_enabled(bufnr)
  local enabled = vim.b[bufnr or 0].autoformat
  if enabled == nil then
    enabled = vim.g.autoformat
  end
  return enabled == true
end

-- Only languages listed in config/languages.lua are set up, aliases like cpp
-- share the table of their language and follow it.
local function enabled_tools_by_ft()
  local by_ft = require("config.tools").by_ft
  local ok, languages = pcall(require, "config.languages")
  if not ok then
    languages = {}
  end

  local enabled = {}
  for _, language in ipairs(languages) do
    if by_ft[language] then
      enabled[by_ft[language]] = true
    else
      vim.notify("Unknown language in config/languages.lua: " .. language, vim.log.levels.WARN)
    end
  end

  local result = {}
  for ft, cfg in pairs(by_ft) do
    if enabled[cfg] then
      result[ft] = cfg
    end
  end
  return result
end

local tools_by_ft = enabled_tools_by_ft()

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
      for _, server in ipairs(cfg.lsp) do
        add_unique(result, seen, server)
      end
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
    return cfg.install == "mason"
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
    if cfg.install == "mason" then
      for _, list in ipairs({ cfg.formatters or {}, cfg.linters or {}, cfg.tools or {} }) do
        for _, tool in ipairs(list) do
          add_unique(result, seen, M.mason_pkg_aliases[tool] or tool)
        end
      end
    end
  end
  return result
end

-- Unique treesitter parsers: base parsers plus those of the enabled languages.
function M.treesitter_parsers()
  local seen, result = {}, {}
  for _, parser in ipairs(require("config.tools").base_parsers) do
    add_unique(result, seen, parser)
  end
  for _, cfg in pairs(tools_by_ft) do
    for _, parser in ipairs(cfg.parsers or {}) do
      add_unique(result, seen, parser)
    end
  end
  return result
end

-- Mason Aliases
M.mason_pkg_aliases = {
  ruff_format = "ruff",
}

return M
