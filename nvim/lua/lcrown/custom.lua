-- open vs code to the current working directory and with the current file
function VSCode()
  local cwd = vim.fn.getcwd()
  local filepath = vim.fn.expand('%:p')
  vim.cmd(string.format("silent !code -n %s", cwd))
  vim.cmd(string.format("silent !code -r %s", filepath))
end

-- formats the current file with the configured formatter
function Format()
  local filetype = vim.bo.filetype
  local current_file = vim.fn.expand("%:p")

  local formatters = {
    python = 'black',
    ruby = 'rubocop -a',
    go = 'gofmt -w',
  }

  local format_prefix
  for l,p in pairs(formatters) do
    if filetype == l then
      format_prefix = p
    end
  end

  if format_prefix == nil then
    print(string.format("no formatter configured for '%s'", filetype))
    return
  end

  local cmd = string.format("silent exec \"!%s %s\"", format_prefix, current_file)
  vim.api.nvim_command(cmd)
  vim.api.nvim_command("mode")
  vim.api.nvim_command("edit")
end

local function has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function Shell(cmd)
  local f = io.popen(cmd)
  local s = f:read('*a')
  f:close()
  return s
end

function Json_pretty(json)
  local fc = string.sub(json, 1, 1)
  local q = {"\'", "\""}
  if not has_value(q, fc) then
    json = '\'' .. json .. '\''
  end
  local j = Shell(string.format("echo %s | jq", json))
  return j
end
