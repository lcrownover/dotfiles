return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
    "L3MON4D3/LuaSnip",
    "windwp/nvim-autopairs",
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

    cmp.setup({
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      -- sources for autocompletion
      sources = {
        { name = "copilot",  priority = 5 },   -- copilot
        { name = "nvim_lsp", priority = 4 },   -- lsp
        { name = "luasnip",  priority = 3 },   -- snippets
        { name = "path",     priority = 2 },   -- os path
        { name = "buffer",   priority = 1 },   -- current buffer
      },
      -- configure completion icons
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = {
            Copilot = "",
          },
        }),
      },
      min_length = 0,   -- allow for `from package import _` in Python
      -- experimental = { ghost_text = true },
    })

    -- make autopairs and completion work together
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
