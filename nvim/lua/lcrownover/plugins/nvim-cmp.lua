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
      select = true,
    }),
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  -- sources for autocompletion
  sources = {
    { name = "nvim_lsp" }, -- lsp
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- current buffer
    { name = "path" }, -- os path
  },

  -- configure completion icons
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },

  min_length = 0, -- allow for `from package import _` in Python
  experimental = { ghost_text = true },
})

require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})
require("luasnip.loaders.from_vscode").load()

require("snippy").setup({
  mappings = {
    is = {
      ["<Tab>"] = "expand_or_advance",
      ["<S-Tab"] = "previous",
    },
    nx = {
      ["<leader>x"] = "cut_text",
    },
  },
})
