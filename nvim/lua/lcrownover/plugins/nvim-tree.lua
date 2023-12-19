return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<C-b>", ":NvimTreeToggle<CR>", silent = true },
    { "<leader>b", ":NvimTreeFindFile<CR>", silent = true },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "right",
        width = 50,
      },
      filter = {
        custom = { "^.git$" },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
}
