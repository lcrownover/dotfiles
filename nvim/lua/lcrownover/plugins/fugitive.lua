return {
  "tpope/vim-fugitive",
  opts = {},
  config = true,
  keys = {
    { "<leader>gs", ":Git<cr>" },
    { "<leader>gc", ":Git commit<cr>" },
    { "<leader>gp", ":Git push<cr>" },
    { "<leader>gb", ":Git blame<cr>" },
    { "<leader>gd", ":Gvdiffsplit<cr>" },
    { "<leader>gh", ":diffget //2<cr>" },
    { "<leader>gl", ":diffget //3<cr>" },
  },
}
