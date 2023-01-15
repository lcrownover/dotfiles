return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
    })
  end,
}
