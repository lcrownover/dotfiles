return {
  "hoob3rt/lualine.nvim",
  config = function()
    local function lsp_status()
      if #vim.lsp.get_active_clients() == 0 then
        return "⚠"
      else
        return "✓"
      end
    end

    require("lualine").setup({
      options = {
        theme = vim.g.lualine_theme,
      },
      sections = {
        lualine_b = { "branch" },
        lualine_x = { "encoding", "fileformat", "filetype", lsp_status },
      },
    })
  end,
}
