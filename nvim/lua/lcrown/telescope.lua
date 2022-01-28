require('telescope').setup{
    extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
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
        file_ignore_patterns = {
            "node_modules",
            "Music",
            "Library",
            "venv",
        },
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        -- check the ":h telescope.nvim" docs for other settings
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = {
                    ["<leader>w"] = require("telescope.actions").delete_buffer,
                },
                n = {
                    ["<leader>w"] = require("telescope.actions").delete_buffer,
                }
            }
        },
        -- cache_picker = {
          -- num_pickers = 20,
        -- },
    }
}
require('telescope').load_extension('fzf')

local M = {}

M.grep_notes = function()
    require('telescope.builtin').live_grep({
        prompt_title = "< Grep Notes >",
        shorten_path = true,
        search_dirs = {"~/OneDrive - University Of Oregon/notes"},
    })
end

return M
