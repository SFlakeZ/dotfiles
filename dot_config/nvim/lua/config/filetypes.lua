-- Filetypes neovim does not detect on its own. Anything else can be set per
-- file with a modeline, e.g. `# vim: ft=yaml.ansible`

-- Helm templates and values only inside a chart
local function in_chart(ft)
  return function(path)
    if vim.fs.root(path, "Chart.yaml") then
      return ft
    end
  end
end

vim.filetype.add({
  extension = {
    j2 = "jinja",
    jinja2 = "jinja",
    -- podman quadlets
    container = "systemd",
    volume = "systemd",
    network = "systemd",
    kube = "systemd",
    image = "systemd",
  },
  pattern = {
    ["compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%..+%.ya?ml"] = "yaml.docker-compose",
    ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    ["docker%-compose%..+%.ya?ml"] = "yaml.docker-compose",
    [".*/playbooks?/.+%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/tasks/.+%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/handlers/.+%.ya?ml"] = "yaml.ansible",
    [".*/templates/.+%.ya?ml"] = in_chart("helm"),
    [".*/templates/.+%.tpl"] = in_chart("helm"),
    [".*/values[^/]*%.ya?ml"] = in_chart("yaml.helm-values"),
  },
})
