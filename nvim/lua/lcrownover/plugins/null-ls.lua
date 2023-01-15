return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.shfmt,
      },
    })
  end,
}