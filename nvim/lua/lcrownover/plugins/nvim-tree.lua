return {
  "kyazdani42/nvim-tree.lua",
  event = "BufEnter",
  keys = {
    { "<C-b>", ":NvimTreeToggle<CR>" },
    { "<leader>b", ":NvimTreeFindFile<CR>" },
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      sync_root_with_cwd = true,
      view = {
        side = "right",
        adaptive_size = true,
        mappings = {
          list = {
            { key = "u", action = "dir_up" },
            { key = "<leader>s\\", action = "vsplit" },
            { key = "<leader>s-", action = "split" },
          },
        },
      },
      renderer = {
        group_empty = true,
        add_trailing = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
}
