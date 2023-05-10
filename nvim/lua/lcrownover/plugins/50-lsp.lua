return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_null_ls = require("mason-null-ls")

      mason.setup()

      mason_lspconfig.setup({
        automatic_installation = true,
        ensure_installed = {
          -- lsp servers
          "ansiblels",
          "awk_ls",
          "bashls",
          "clangd",
          "dockerls",
          "eslint",
          "gopls",
          "html",
          "marksman",
          "puppet",
          "pyright",
          "rust_analyzer",
          "solargraph",
          "svelte",
          "lua_ls",
          "terraformls",
          "tsserver",
          "vimls",
        },
      })

      mason_null_ls.setup({
        automatic_installation = true,
        ensure_installed = {
          "black",
          "rubocop",
          "jq",
          "shfmt",
          "markdownlint",
          "prettier",
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.jq,
          null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.prettier
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup()
        end,
      },
      "ray-x/lsp_signature.nvim",
      "rodjek/vim-puppet",
      "simrat39/rust-tools.nvim",
      "Vimjas/vim-python-pep8-indent", -- fix until treesitter python and yaml indent is fixed
      "fatih/vim-go",
      "folke/neodev.nvim",
    },
    keys = {
      { "gd",         "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>" },
      { "gD",         "<cmd>lua vim.lsp.buf.declaration()<cr>" },
      { "gr",         "<cmd>lua require('telescope.builtin').lsp_references()<cr>" },
      { "gi",         "<cmd>lua vim.lsp.buf.implementation()<cr>" },
      { "ga",         "<cmd>lua vim.lsp.buf.code_action()<CR>" },
      { "<leader>e",  "<cmd>lua vim.diagnostic.open_float()<CR>" },
      { "<leader>fs", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>" },
      { "[d",         "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
      { "]d",         "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },
      { "<leader>lr", ":LspRestart<cr>" },
      { "<leader>li", ":LspInfo<cr>" },
      { "<leader>lh", "<cmd>lua require('rust-tools').inlay_hints.toggle()<CR>" }
    },
    config = function()
      -- helper for quickly setting format override options per-language
      local set_fmt = function(file_patterns, indent_length, expandtab)
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
          pattern = file_patterns,
          callback = function()
            if expandtab then
              vim.opt.expandtab = true
            else
              vim.opt.expandtab = false
            end
            vim.opt.tabstop = indent_length
            vim.opt.shiftwidth = indent_length
          end,
        })
      end

      local on_attach = function(_, bufnr)
        require("lsp_signature").on_attach({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
        }, bufnr)
        require("lsp-inlayhints").on_attach(_, bufnr)
      end

      -- pass capabilities into each lsp server
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- shortcut
      local lsp = require("lspconfig")

      ------------------------------------------------------------------------------
      -- Any server that doesn't have specific configuration can go here
      ------------------------------------------------------------------------------
      local basic_servers = {
        "gopls",         -- golang
        "solargraph",    -- ruby
        "rust_analyzer", -- rust
        "tsserver",      -- typescript
        "bashls",        -- bash
        "vimls",         -- vim
        "puppet",        -- puppet
        "clangd",        -- c
        "cssls",         -- css
        "perlls",        -- perl
        "html",
        "svelte",
      }
      for _, server in ipairs(basic_servers) do
        lsp[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      ---------------------------------------
      -- python
      ---------------------------------------
      lsp["pyright"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoImportCompletions = false,
            },
          },
        },
      })

      ---------------------------------------
      -- ansible
      ---------------------------------------
      set_fmt({ "*.yml" }, 2, true)
      lsp["ansiblels"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "yaml.ansible",
          "yml",
          "yaml",
        },
      })

      ---------------------------------------
      -- golang
      ---------------------------------------
      set_fmt({ "*.go" }, 4, false)
      vim.g.go_doc_keywordprg_enabled = 0 -- disable "K" in vim-go
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.go",
        callback = function()
          vim.keymap.set("n", "<leader>lr", ":!go run cmd/*/main.go<cr>")
        end,
      })

      ---------------------------------------
      -- ruby
      ---------------------------------------
      set_fmt({ "*.rb", "*.pp" }, 2, true)
      lsp["solargraph"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          solargraph = {
            formatting = true,
          },
        },
      })

      ---------------------------------------
      -- lua
      ---------------------------------------
      set_fmt({ "*.lua" }, 2, true)
      lsp["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      ---------------------------------------
      -- rust
      ---------------------------------------
      require("rust-tools").setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
        tools = {
          inlay_hints = {
            auto = false,
          },
        },
      })

      ---------------------------------------
      -- terraform
      ---------------------------------------
      set_fmt("*.tf", 2, true)
      lsp["terraformls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "terraform",
          "tf",
        },
      })

      ---------------------------------------
      -- typescript/javascript
      ---------------------------------------
      set_fmt({ "*.ts", "*.js", "*.jsx" }, 2, true)

      ---------------------------------------
      -- markdown
      ---------------------------------------
      set_fmt({ "*.md" }, 2, true)
    end,
  },
  {
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
          { name = "copilot",  priority = 5 }, -- copilot
          { name = "nvim_lsp", priority = 4 }, -- lsp
          { name = "luasnip",  priority = 3 }, -- snippets
          { name = "path",     priority = 2 }, -- os path
          { name = "buffer",   priority = 1 }, -- current buffer
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
        min_length = 0, -- allow for `from package import _` in Python
        -- experimental = { ghost_text = true },
      })

      -- make autopairs and completion work together
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    keys = {
      { "gh",   "<cmd>Lspsaga lsp_finder<CR>" },
      { "K",    "<cmd>Lspsaga hover_doc<CR>" },
      { "gn",   "<cmd>Lspsaga rename<CR>" },
      { "<F2>", "<cmd>Lspsaga rename<CR>" },
      { "gs",   "<cmd>Lspsaga peek_definition<CR>" },
      { "[e",   "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
      { "]e",   "<cmd>Lspsaga diagnostic_jump_next<CR>" },
      {
        "[E",
        function()
          require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
      },
      {
        "]E",
        function()
          require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
      },
    },
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        ui = {
          title = false,
        },
      })
    end,
  },

}
