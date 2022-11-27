-- don't search here
local file_ignore_patterns = {
  "node_modules",
  "Music",
  "Library",
  "venv",
}

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",
    }
  },
  defaults = {
    -- added "follow" to the other defaults so it follows symlinks
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--follow',
    },
    file_ignore_patterns = file_ignore_patterns,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    mappings = {
      i = {
        ["<c-k>"] = require("telescope.actions").move_selection_previous,
        ["<c-j>"] = require("telescope.actions").move_selection_next,
      },
      n = {
        ["<c-k>"] = require("telescope.actions").move_selection_previous,
        ["<c-j>"] = require("telescope.actions").move_selection_next,
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = { ["<leader>w"] = require("telescope.actions").delete_buffer },
        n = { ["<leader>w"] = require("telescope.actions").delete_buffer },
      }
    },
  }
}
require('telescope').load_extension('fzf')

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
