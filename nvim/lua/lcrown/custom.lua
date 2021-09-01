-- formats the current file with the configured formatter
function format()
  filetype = vim.bo.filetype
  current_file = vim.fn.expand("%:p")

  formatters = {
    python = 'black',
    ruby = 'rubocop -a',
    go = 'gofmt -w',
  }

  for l,p in pairs(formatters) do
    if filetype == l then
      format_prefix = p
    end
  end

  if format_prefix == nil then
    print(string.format("no formatter configured for '%s'", filetype))
    return
  end

  cmd = string.format("silent exec \"!%s %s\"", format_prefix, current_file)
  vim.api.nvim_command(cmd)
  vim.api.nvim_command("mode")
  vim.api.nvim_command("edit")
end

