return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  config = function()
    require("ibl").setup({
      scope = { enabled = false },
    })
  end,
}
