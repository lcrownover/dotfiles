return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {})
    vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
    vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
    vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {})
    vim.keymap.set("n", "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>", {})
    vim.keymap.set("n", "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", {})
    vim.keymap.set("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", {})
    vim.keymap.set("n", "<leader>fa", "<cmd>lua require('telescope.builtin').autocommands()<cr>", {})
    vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').highlights()<cr>", {})
    -- vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", {})

    local file_ignore_patterns = {
      "node_modules",
      "Music",
      "Library",
      "venv",
    }
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = file_ignore_patterns,
        mappings = {
          i = {
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<c-j>"] = require("telescope.actions").move_selection_next,
          },
        },
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          mappings = {
            i = { ["<leader>w"] = require("telescope.actions").delete_buffer },
            n = { ["<leader>w"] = require("telescope.actions").delete_buffer },
          },
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}
