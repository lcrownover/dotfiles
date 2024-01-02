return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- javascript
        null_ls.builtins.diagnostics.eslint_d,
        -- python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.ruff,
        -- ansible
        null_ls.builtins.diagnostics.ansiblelint,
        -- sh
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,
        -- markdown
        null_ls.builtins.diagnostics.markdownlint,
        -- everything else
        null_ls.builtins.formatting.prettier,
      },
    })
  end,
}
