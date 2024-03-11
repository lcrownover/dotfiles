return {
  "tpope/vim-fugitive",
  config = true,
  keys = {
    { "<leader>gs", ":Git<cr>" },
    { "<leader>gp", ":Git pull<cr>" },
    { "<leader>gP", ":Git push<cr>" },
    { "<leader>gb", ":Git blame<cr>" },
    { "<leader>gd", ":Gvdiffsplit<cr>" },
    { "<leader>gh", ":diffget //2<cr>" },
    { "<leader>gl", ":diffget //3<cr>" },
  },
}
