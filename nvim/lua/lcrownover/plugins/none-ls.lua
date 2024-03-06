return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- python
        null_ls.builtins.formatting.isort,
        -- ansible
        null_ls.builtins.diagnostics.ansiblelint,
        -- sh
        null_ls.builtins.formatting.shfmt,
        -- markdown
        null_ls.builtins.diagnostics.markdownlint,
        -- everything else
        null_ls.builtins.formatting.prettier,
      },
    })
  end,
}
