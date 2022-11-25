vim.api.nvim_create_autocmd( {"BufNewFile", "BufRead"}, {
  pattern = {
    "*.rb",
    "*.pp",
    "*.lua",
    "*.tf",
    "*.ts",
    "*.js",
    "*.jsx",
    "*.md",
  },
  command = "setlocal expandtab ts=2 sw=2 sts=2",
})

require('trim').setup({
  patterns = {
    [[%s/\s\+$//e]], -- remove unwanted spaces
    [[%s/\($\n\s*\)\+\%$//]], -- trim last line
    [[%s/\%^\n\+//]], -- trim first line
  },
})
