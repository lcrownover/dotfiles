-- autocompletion
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
    -- snippets
    -- {
    --   "L3MON4D3/LuaSnip",
    --   dependencies = {
    --     "rafamadriz/friendly-snippets",
    --     config = function()
    --       require("luasnip.loaders.from_vscode").lazy_load()
    --     end,
    --   },
    --   config = {
    --     history = true,
    --     delete_check_events = "TextChanged",
    --   },
    -- },
    -- "dcampos/nvim-snippy",
    -- "honza/vim-snippets",
    -- "dcampos/cmp-snippy",
    "windwp/nvim-autopairs",
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

    -- require("luasnip").config.set_config({
    --   history = true,
    --   updateevents = "TextChanged,TextChangedI",
    -- })
    --
    -- require("snippy").setup({
    --   mappings = {
    --     is = {
    --       ["<Tab>"] = "expand_or_advance",
    --       ["<S-Tab"] = "previous",
    --     },
    --     nx = {
    --       ["<leader>x"] = "cut_text",
    --     },
    --   },
    -- })
    --
    -- make autopairs and completion work together
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
