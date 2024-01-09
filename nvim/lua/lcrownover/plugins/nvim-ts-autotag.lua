-- write close tags automatically
return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
