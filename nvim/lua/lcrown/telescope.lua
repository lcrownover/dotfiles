require('telescope').setup{
    extensions = {
        fzy = {
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
        }
    },
    defaults = {
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
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "    ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {
            "node_modules",
            "Music",
            "Library",
            "venv",
        },
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
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
        cache_picker = {
          num_pickers = 20,
        },
    }
}

require('telescope').load_extension('fzf')

local M = {}

M.grep_notes = function()
    require('telescope.builtin').live_grep({
        prompt_title = "< Grep Notes >",
        shorten_path = true,
        search_dirs = {"~/Google Drive/My Drive/notes"},
    })
end

return M
