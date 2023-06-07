return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<C-b>",     ":NvimTreeToggle<CR>",   silent = true },
        { "<leader>b", ":NvimTreeFindFile<CR>", silent = true },
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                side = "right",
            },
        })
    end,
}
