local theme = vim.g.theme

local function lsp_status()
    if #vim.lsp.buf_get_clients() == 0 then
        return '⚠'
    else
        return '✓'
    end
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype', lsp_status},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

<<<<<<< HEAD
=======
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
  }
}

>>>>>>> 2263808740f6cc876e2b2cf9cc78c377663f4368
