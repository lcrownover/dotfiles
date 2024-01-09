return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = true,
  keys = {
    { "<leader>tt", ":Trouble<cr>", silent = true },
    { "<leader>tq", ":TroubleClose<cr>", silent = true },
    { "<leader>tr", ":TroubleRefresh<cr>", silent = true },
  },
}
