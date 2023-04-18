-- telescope
return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", silent = true },
    { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", silent = true },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", silent = true },
    { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", silent = true },
    { "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>", silent = true },
    { "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", silent = true },
    { "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", silent = true },
    { "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", silent = true },
    { "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<cr>", silent = true },
    { "<leader>fa", "<cmd>lua require('telescope.builtin').autocommands()<cr>", silent = true },
    { "<leader>fl", "<cmd>lua require('telescope.builtin').highlights()<cr>", silent = true },
  },
  config = function()
    local file_ignore_patterns = {
      "node_modules",
      "Music",
      "Library",
      "venv",
    }
    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case",
        },
      },
      defaults = {
        -- added "follow" to the other defaults so it follows symlinks
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--follow",
        },
        file_ignore_patterns = file_ignore_patterns,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
          i = {
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<c-j>"] = require("telescope.actions").move_selection_next,
          },
          n = {
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
    -- local M = {}
    --
    -- M.grep_notes = function()
    --   require('telescope.builtin').live_grep({
    --     prompt_title = "< Grep Notes >",
    --     shorten_path = true,
    --     search_dirs = { "~/.gdrive/notes" },
    --   })
    -- end
    --
    -- return M
  end,
}
