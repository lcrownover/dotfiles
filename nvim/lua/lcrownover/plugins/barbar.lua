return {
  "romgrk/barbar.nvim",
  event = "BufReadPre",
  keys = {
    { "<C-n>", "<cmd>BufferNext<cr>" },
    { "<C-p>", "<cmd>BufferPrevious<cr>" },
  },
  config = function()
    require("bufferline").setup()
  end,
}
