-- My entire config is in one file because the dream is to be
-- able to copy this single file to a new machine and have everything
-- auto install and work.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- #---------------------------------------------------------------------------#
--    Core options for configuring Neovim
-- #---------------------------------------------------------------------------#

-- concise
local opt = vim.opt

-- no startup message
opt.shortmess:append({ I = true })

-- disable netrw - this needs to be set super early in the config
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- termguicolors - enable true colors support
opt.termguicolors = true

-- updatetime - how many milliseconds until the swap file is written
opt.updatetime = 1000

-- timeoutlen - how long to wait for a mapped sequence to complete
opt.timeoutlen = 1000

-- undofile - save undo history
opt.undofile = true

-- cursorline - highlight the current line
opt.cursorline = true

-- colorcolumn - highlight columns
opt.colorcolumn = "80,120"

-- indentkeys:remove - remove some indent keys
-- opt.indentkeys:remove(":,<:>")

-- listchars - representation of whitespace characters
opt.listchars:append({ tab = "├─", trail = "·", eol = "↲", space = "_" })

-- wrap - wrap lines
opt.wrap = false

-- line numbers
opt.number = true
opt.relativenumber = true

-- scrolloff - how many lines to keep above and below the cursor
opt.scrolloff = 10
opt.sidescrolloff = 10

-- signcolumn - always show the sign column
opt.signcolumn = "yes"

-- errorbells - turn that shit off
opt.errorbells = false

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- mouse and clipboard
opt.mouse:append("a")
opt.clipboard = "unnamedplus"

-- searching
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- default formatting if not overridden by LSP configuration
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- splits
opt.splitbelow = true
opt.splitright = true

-- treesitter folding
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- this will toggle the visibility of whitespace characters
function ToggleWhitespaceVisibility()
  opt.list = not opt.list:get()
end

-- this flashes the current selection when I yank it
-- it's kinda cool :)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

-- #---------------------------------------------------------------------------#
--    Plugins! Plugins! Plugins!
-- #---------------------------------------------------------------------------#
require("lazy").setup({
  -- This list is generally organized from simpler stuff first
  -- to more complex configurations towards the end.
  -- The loading order doesn't really matter.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- flavour = "frappe",
        flavour = "macchiato",
      })
      vim.cmd.colorscheme("catppuccin")
      vim.g.lualine_theme = "catppuccin"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "cappyzawa/trim.nvim",
    cmd = "Trim",
    config = true,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    keys = {
      { "<leader>tt", ":Trouble<cr>",        silent = true },
      { "<leader>tq", ":TroubleClose<cr>",   silent = true },
      { "<leader>tr", ":TroubleRefresh<cr>", silent = true },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
  {
    -- Just adds some flavor to various UI elements
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    -- write close tags automatically
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        scope = { enabled = false },
      })
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    lazy = false,
    config = function()
      require("lualine").setup({
        options = {
          theme = vim.g.lualine_theme,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "markdown_inline" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      { "<leader>mp", ":MarkdownPreviewToggle<CR>", silent = true },
      { "<leader>ms", ":MarkdownPreviewStop<CR>",   silent = true },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "tpope/vim-fugitive",
    config = true,
    keys = {
      { "<leader>gs", ":Git<cr>" },
      { "<leader>gp", ":Git pull<cr>" },
      { "<leader>gP", ":Git push<cr>" },
      { "<leader>gb", ":Git blame<cr>" },
      { "<leader>gd", ":Gvdiffsplit<cr>" },
      { "<leader>gh", ":diffget //2<cr>" },
      { "<leader>gl", ":diffget //3<cr>" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<A-;>",
            dismiss = "<A-BS>",
          },
        },
        filetypes = {
          yaml = true,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<c-b>",     ":Neotree toggle<CR>", { silent = true } },
      { "<leader>b", ":Neotree reveal<CR>", { silent = true } },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 50,
          position = "right",
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
        },
      })
    end,
  },
  {
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
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.keymap.set("n", "<c-p>", "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {})
      vim.keymap.set("n", "<c-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
      vim.keymap.set(
        "n",
        "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>",
        {}
      )
      vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
      vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
      vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {})
      vim.keymap.set("n", "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>", {})
      vim.keymap.set("n", "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", {})
      vim.keymap.set("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", {})
      vim.keymap.set("n", "<leader>fa", "<cmd>lua require('telescope.builtin').autocommands()<cr>", {})
      vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').highlights()<cr>", {})
      -- vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", {})

      local file_ignore_patterns = {
        "node_modules",
        "Music",
        "Library",
        "venv",
      }
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = file_ignore_patterns,
          mappings = {
            i = {
              ["<c-k>"] = require("telescope.actions").move_selection_previous,
              ["<c-j>"] = require("telescope.actions").move_selection_next,
            },
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = { ["<leader>w"] = require("telescope.actions").delete_buffer },
              n = { ["<leader>w"] = require("telescope.actions").delete_buffer },
            },
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        automatic_installation = true,
        ensure_installed = {
          "ansiblels",
          "bashls",
          "dockerls",
          "gopls",
          "html",
          "marksman",
          "pyright",
          "rust_analyzer",
          "lua_ls",
          "terraformls",
          "svelte",
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "isort",
          "ruff",
          "eslint_d",
          "ansible-lint",
          "shfmt",
          "shellcheck",
          "markdownlint",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    opts = {
      inlay_hints = { enable = true },
    },
    dependencies = {
      {
        "j-hui/fidget.nvim",
        tag = "v1.1.0",
        config = function()
          require("fidget").setup()
        end,
      },
      {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
          require("lspsaga").setup({
            symbol_in_winbar = { enable = false },
            lightbulb = { enable = false },
            ui = { title = false },
          })
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = true,
      },
      -- {
      --   "lvimuser/lsp-inlayhints.nvim",
      --   config = function()
      --     require("lsp-inlayhints").setup({
      --       enabled_at_startup = false,
      --     })
      --   end,
      -- },
      {
        "simrat39/rust-tools.nvim",
        event = "LspAttach",
        ft = "rust",
      },
    },
    config = function()
      ------------------------------------------------------------------
      --   Keymaps
      ------------------------------------------------------------------
      local opts = { silent = true, noremap = true }

      opts.desc = "Show LSP definitions"
      vim.keymap.set("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)

      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)

      opts.desc = "Show LSP references"
      vim.keymap.set("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

      opts.desc = "Show LSP implementations"
      vim.keymap.set("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)

      opts.desc = "Restart LSP server"
      vim.keymap.set("n", "<leader>lr", ":LspRestart<cr>", opts)

      opts.desc = "Show LSP info"
      vim.keymap.set("n", "<leader>li", ":LspInfo<cr>", opts)

      opts.desc = "LSP Format"
      vim.keymap.set({ "n", "v" }, "<leader>fs", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

      -- Native LSP
      -- opts.desc = "Show LSP hover doc"
      -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      -- opts.desc = "Show LSP diagnostics"
      -- vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts.)
      -- opts.desc = "Show LSP code actions"
      -- vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      -- opts.desc = "LSP rename symbol"
      -- vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      -- opts.desc = "LSP rename symbol"
      -- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      -- opts.desc = "Go to previous LSP diagnostic"
      -- vim.keymap.set("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
      -- opts.desc = "Go to next LSP diagnostic"
      -- vim.keymap.set("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

      -- Lspsaga
      opts.desc = "Show LSP hover doc"
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

      opts.desc = "Show LSP diagnostics"
      vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

      opts.desc = "LSP rename symbol"
      vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>", opts)

      opts.desc = "LSP rename symbol"
      vim.keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)

      opts.desc = "LSP peek definition"
      vim.keymap.set("n", "gs", "<cmd>Lspsaga peek_definition<CR>", opts)

      opts.desc = "Show LSP code actions"
      vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>", opts)

      opts.desc = "Go to previous LSP diagnostic"
      vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

      opts.desc = "Go to next LSP diagnostic"
      vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

      opts.desc = "Go to previous LSP diagnostic"
      vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })

      opts.desc = "Go to next LSP diagnostic"
      vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })

      ------------------------------------------------------------------
      --   Inlay Hints
      ------------------------------------------------------------------
      -- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = "LspAttach_inlayhints",
      --   callback = function(args)
      --     if not (args.data and args.data.client_id) then
      --       return
      --     end
      --
      --     local bufnr = args.buf
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     require("lsp-inlayhints").on_attach(client, bufnr)
      --   end,
      -- })

      ------------------------------------------------------------------
      --   lsp_signature
      ------------------------------------------------------------------
      vim.api.nvim_create_augroup("LspAttach_signature", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_signature",
        callback = function(args)
          local bufnr = args.buf
          require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
              border = "rounded",
            },
          }, bufnr)
        end,
      })

      ------------------------------------------------------------------
      -- Language Servers
      ------------------------------------------------------------------

      local lsp = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      ---------------------------------------
      -- rust
      ---------------------------------------
      lsp["rust_analyzer"].setup({
        capabilities = lsp_capabilities,
      })
      local rustlsp = vim.api.nvim_create_augroup("RustLSP", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = rustlsp,
        pattern = "*.rs",
        callback = function()
          vim.opt.tabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = true
          -- vim.api.nvim_buf_set_keymap(
          --   0,
          --   "n",
          --   "<leader>lh",
          --   "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
          --   { silent = true }
          -- )
        end,
      })

      ---------------------------------------
      -- bash
      ---------------------------------------
      lsp["bashls"].setup({
        capabilities = lsp_capabilities,
      })

      ---------------------------------------
      -- css
      ---------------------------------------
      lsp["cssls"].setup({
        capabilities = lsp_capabilities,
      })

      ---------------------------------------
      -- html
      ---------------------------------------
      lsp["html"].setup({
        capabilities = lsp_capabilities,
      })

      ---------------------------------------
      -- python
      ---------------------------------------
      lsp["pyright"].setup({
        capabilities = lsp_capabilities,
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
      lsp["ansiblels"].setup({
        capabilities = lsp_capabilities,
        filetypes = {
          "yml.ansible",
          "yml",
          "yaml",
        },
      })

      ---------------------------------------
      -- golang
      ---------------------------------------
      lsp["gopls"].setup({
        capabilities = lsp_capabilities,
        settings = {
          gopls = {
            staticcheck = true,
          },
        },
      })
      local golsp = vim.api.nvim_create_augroup("GoLSP", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = golsp,
        pattern = "*.go",
        callback = function()
          vim.opt.tabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = false
        end,
      })

      ---------------------------------------
      -- lua
      ---------------------------------------
      lsp["lua_ls"].setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "require" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      local lualsp = vim.api.nvim_create_augroup("LuaLSP", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lualsp,
        pattern = "*.lua",
        callback = function()
          vim.opt.tabstop = 2
          vim.opt.shiftwidth = 2
          vim.opt.expandtab = true
        end,
      })

      ---------------------------------------
      -- rust
      ---------------------------------------
      require("rust-tools").setup({
        server = {
          capabilities = lsp_capabilities,
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
      lsp["terraformls"].setup({
        capabilities = lsp_capabilities,
        filetypes = {
          "terraform",
          "tf",
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "neovim/nvim-lspconfig",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "windwp/nvim-autopairs",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "nvim_lsp" },
          -- { name = "copilot" },
          { name = "path" },
          { name = "buffer" },
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
      })

      -- make autopairs and completion work together
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    --
    -- Make sure to `pip install debugpy` !!!
    --
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add debuggers
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        -- automatic_installation = true,
        ensure_installed = {
          "delve",
          "debugpy",
        },
      })

      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      require("dap-go").setup()
      require("dap-python").setup()
    end,
  },
})

-- #---------------------------------------------------------------------------#
--    General keymaps are configured after plugins are loaded
--    because I don't want to deal with plugins overriding my keymaps
--    without me knowing about it.
-- #---------------------------------------------------------------------------#

local bind = vim.keymap.set

-- centering screen on next find results
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")

-- better joining
bind("n", "J", "mzJ`z")

-- delete single character without copying into register
bind("n", "x", '"_x')

-- splits
bind("n", "<c-w>-", ":split<cr>", { silent = true, desc = "Horizontal split" })
bind("n", "<c-w>\\", ":vsplit<cr>", { silent = true, desc = "Vertical split" })
bind("n", "<c-w>w", ":close<cr>", { silent = true, desc = "Close split" })

-- toggle showing of whitespace characters
bind(
  "n",
  "<leader>sw",
  ":lua ToggleWhitespaceVisibility()<CR>",
  { silent = true, desc = "Toggle whitespace visibility" }
)

-- close the quickfix window
bind("n", "<leader>co", ":copen<cr>", { silent = true, desc = "Open quickfix window" })
bind("n", "<leader>cc", ":cclose<cr>", { silent = true, desc = "Close quickfix window" })

-- scratch buffers, normal or splits
bind("n", "<leader>nn", ":enew<cr>", { silent = true, desc = "New scratch buffer" })
bind("n", "<leader>nv", ":vnew<cr>", { silent = true, desc = "New scratch buffer (vertical)" })
bind("n", "<leader>nh", ":new<cr>", { silent = true, desc = "New scratch buffer (horizontal)" })

-- toggle sign column for copy-paste
bind("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>", { silent = true, desc = "Toggle line numbers" })

-- close buffer
bind("n", "<leader>w", ":bd<cr>", { silent = true })

-- keep visual mode after indenting
bind("x", ">", ">gv")
bind("x", "<", "<gv")

-- quick key for regex
bind("n", "<leader>r", ":%s/", { desc = "Search and replace entire buffer" })
bind("x", "<leader>r", ":s/", { desc = "Search and replace selection" })

-- break undo sequence after punctuation
bind("i", ",", ",<c-g>u")
bind("i", ".", ".<c-g>u")
bind("i", "!", "!<c-g>u")
bind("i", "?", "?<c-g>u")

-- execute the current buffer with bash
-- bind("n", "<leader>xb", ":w !bash<cr>")

-- execute current file
-- bind("n", "<leader>xf", ":!%:p<cr>")

-- git
-- bind("n", "<leader>gg", ":terminal lazygit<cr>i")

-- diffing files
-- bind('n', '<leader>d<', ':diffthis<cr>')
-- bind('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- bind('n', '<leader>dq', ':diffoff<cr>')

-- telescope custom locations
-- bind('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- bind('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- go to the directory of the current buffer
-- bind('n', '<leader>c', ':cd %:p:h<cr>')

-- extra stuff to save
-- {
--     "sainnhe/everforest",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.g.everforest_background = "medium"
--         vim.g.everforest_better_performance = 1
--         vim.cmd([[colorscheme everforest]])
--         vim.g.lualine_theme = "everforest"
--     end,
-- },
