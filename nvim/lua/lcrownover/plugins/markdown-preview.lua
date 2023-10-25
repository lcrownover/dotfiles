return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    { "<leader>mp", ":MarkdownPreviewToggle<CR>", silent = true },
    { "<leader>ms", ":MarkdownPreviewStop<CR>", silent = true },
  },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
