return {
  "iamcco/markdown-preview.nvim",
  ft = "md",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
