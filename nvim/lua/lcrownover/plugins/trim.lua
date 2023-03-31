return {
  "cappyzawa/trim.nvim",
  config = function()
    require("trim").setup({
      patterns = {
        [[%s/\s\+$//e]],      -- remove unwanted spaces
        [[%s/\($\n\s*\)\+\%$//]], -- trim last line
        [[%s/\%^\n\+//]],     -- trim first line
      },
    })
  end,
}
