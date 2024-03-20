--[[

Yes, it's one file. I want it to be easy to simply `curl` my config.

curl -o ~/.config/nvim/init.lua https://raw.githubusercontent.com/lcrownover/nvim/main/init.lua

That's it!

--]]

--[[
===============================================================================
       ____        _   _
      / __ \      | | (_)
     | |  | |_ __ | |_ _  ___  _ __  ___
     | |  | | '_ \| __| |/ _ \| '_ \/ __|
     | |__| | |_) | |_| | (_) | | | \__ \
      \____/| .__/ \__|_|\___/|_| |_|___/
            | |
            |_|
===============================================================================
--]]

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerd font
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- mouse
vim.opt.mouse = "a"

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- don't show the mode, it's already in the statusline
vim.opt.showmode = false

-- no startup message
vim.opt.shortmess:append({ I = true })

-- disable netrw - this needs to be set super early in the config
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- termguicolors - enable true colors support
vim.opt.termguicolors = true

-- updatetime - how many milliseconds until the swap file is written
vim.opt.updatetime = 250

-- timeoutlen - how many milliseconds until a keybinding times out
vim.opt.timeoutlen = 1000

-- undofile - save undo history
vim.opt.undofile = true

-- cursorline - highlight the current line
vim.opt.cursorline = true

-- colorcolumn - highlight columns
vim.opt.colorcolumn = "80,120"

-- indentkeys:remove - remove some indent keys
-- opt.indentkeys:remove(":,<:>")

-- listchars - representation of whitespace characters
vim.opt.listchars:append({ tab = "├─", trail = "·", eol = "↲", nbsp = "␣" })

-- preview substitutions as you write
vim.opt.inccommand = "split"

-- wrap - wrap lines
vim.opt.wrap = false

-- scrolloff - how many lines to keep above and below the cursor
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- signcolumn - always show the sign column
vim.opt.signcolumn = "yes"

-- errorbells - turn that shit off
vim.opt.errorbells = false

-- searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>") -- clear hl on esc

-- default formatting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--[[
===============================================================================
  _      _ _     _     _ _
 | |    (_) |   | |   (_) |
 | |     _| |   | |__  _| |_ ___
 | |    | | |   | '_ \| | __/ __|
 | |____| | |   | |_) | | |_\__ \
 |______|_|_|   |_.__/|_|\__|___/
===============================================================================
--]]

-- this will toggle the visibility of whitespace characters
function ToggleWhitespaceVisibility()
  vim.opt.list = not vim.opt.list:get()
end

-- this flashes the current selection when I yank it
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      -- higroup = "IncSearch",
      -- timeout = 100,
    })
  end,
})

--[[
===============================================================================
      _  __          _     _           _
     | |/ /         | |   (_)         | |
     | ' / ___ _   _| |__  _ _ __   __| |___
     |  < / _ \ | | | '_ \| | '_ \ / _` / __|
     | . \  __/ |_| | |_) | | | | | (_| \__ \
     |_|\_\___|\__, |_.__/|_|_| |_|\__,_|___/
                __/ |
               |___/
===============================================================================
--]]

-- centering screen on next find results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better joining
vim.keymap.set("n", "J", "mzJ`z")

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- keep visual mode after indenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- break undo sequence after punctuation
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- splits
vim.keymap.set("n", "<c-w>-", ":split<cr>", { desc = "Horizontal split" })
vim.keymap.set("n", "<c-w>\\", ":vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<c-w>w", ":close<cr>", { desc = "Close split" })

-- toggle showing of whitespace characters
vim.keymap.set("n", "<leader>sw", ToggleWhitespaceVisibility, { desc = "Toggle whitespace visibility" })

-- close the quickfix window
vim.keymap.set("n", "<leader>cf", ":copen<cr>", { desc = "Open quickfix window" })
vim.keymap.set("n", "<leader>cc", ":cclose<cr>", { desc = "Close quickfix window" })

-- scratch buffers, normal or splits
vim.keymap.set("n", "<leader>nn", ":enew<cr>", { desc = "New scratch buffer" })
vim.keymap.set("n", "<leader>nv", ":vnew<cr>", { desc = "New scratch buffer (vertical)" })
vim.keymap.set("n", "<leader>nh", ":new<cr>", { desc = "New scratch buffer (horizontal)" })

-- toggle sign column for copy-paste
vim.keymap.set("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>", { desc = "Toggle line numbers" })

-- close buffer
vim.keymap.set("n", "<leader>w", ":bd<cr>", { desc = "Close buffer" })

-- quick key for regex
vim.keymap.set("n", "<leader>r", ":%s/", { desc = "Search and replace entire buffer" })
vim.keymap.set("x", "<leader>r", ":s/", { desc = "Search and replace selection" })

-- builtin diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

--[[
===============================================================================
      _____  _             _
     |  __ \| |           (_)
     | |__) | |_   _  __ _ _ _ __  ___
     |  ___/| | | | |/ _` | | '_ \/ __|
     | |    | | |_| | (_| | | | | \__ \
     |_|    |_|\__,_|\__, |_|_| |_|___/
                      __/ |
                     |___/
===============================================================================
--]]

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

require("lazy").setup({

  { -- Color Theme
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme("gruvbox-material")
      vim.g.lualine_theme = "gruvbox-material"
    end,
  },

  { -- Better navigation inside tmux
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  { -- Highlight hex colors found in text
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {},
  },

  { -- Commenting lines or selection
    "numToStr/Comment.nvim",
    event = "BufEnter",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>tt", ":TroubleToggle<cr>", { desc = "Toggle trouble" } },
    },
  },

  { -- Copilot
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

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   event = "VeryLazy",
  --   config = function()
  --     require("ibl").setup({
  --       scope = { enabled = false },
  --     })
  --   end,
  -- },

  { -- Diffview (I don't ever use this...)
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  { -- Styles various picker windows and popups
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  { -- Git actions in Neovim
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

  { -- Auto pairs for brackets, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  { -- Golang specific plugin for increased support
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },

  { -- Telescope! The best fuzzy finder
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons",              enabled = vim.g.have_nerd_font },
    },
    config = function()
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
            mappings = {
              n = { ["x"] = require("telescope.actions").delete_buffer },
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      -- enable telescope extensions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<c-p>", function()
        builtin.find_files({ follow = true })
      end, { desc = "Find files" })
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ follow = true })
      end, { desc = "Find files" })
      vim.keymap.set("n", "<c-g>", builtin.live_grep, { desc = "Find grep" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
      vim.keymap.set("n", "<leader>f;", builtin.resume, { desc = "Find resume" })
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find quickfix" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
      vim.keymap.set("n", "<leader>fa", builtin.autocommands, { desc = "Find autocommands" })
      vim.keymap.set("n", "<leader>fc", builtin.highlights, { desc = "Find colors (highlights)" })
      vim.keymap.set("n", "<leader>fl", builtin.git_commits, { desc = "Find git commits" })
      vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer" })
    end,
  },

  { -- LSP and LSP accessories
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    opts = {
      inlay_hints = { enable = true },
    },
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "folke/neodev.nvim",
        opts = {},
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("attach-lsp", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("gr", require("telescope.builtin").lsp_references, "Goto References")
          map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementations")
          map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          -- map("<leader>ws", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
          map("<leader>lr", ":LspRestart<cr>", "Restart LSP server")
          map("<leader>li", ":LspInfo<cr>", "Show LSP info")
          map("<leader>fs", vim.lsp.buf.format, "LSP Format")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gn", vim.lsp.buf.rename, "Rename Symbol")
          map("<F2>", vim.lsp.buf.rename, "Rename Symbol")
          map("ca", vim.lsp.buf.code_action, "Code Action")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("[e", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("]e", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })
      -- Advertise LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      -- LSP servers
      local servers = {
        bashls = {},
        html = {},
        marksman = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = false,
              },
            },
          },
        },
        ansiblels = {
          filetypes = {
            "yml.ansible",
            "yml",
            "yaml",
          },
        },
        gopls = {
          settings = {
            gopls = {
              staticcheck = true,
            },
          },
        },
        rust_analyzer = {
          tools = {
            inlay_hints = {
              auto = false,
            },
          },
        },
        terraformls = {
          filetypes = {
            "terraform",
            "tf",
          },
        },
        svelte = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                disable = { "missing-fields" },
                globals = { "vim" },
              },
            },
          },
        },
      }
      -- List of formatters and linters to install
      local lsp_tools = {
        "prettier",
        "prettierd",
        "stylua",
        "isort",
        "ruff",
        "eslint_d",
        "ansible-lint",
        "shfmt",
        "shellcheck",
        "markdownlint",
        "yamlfmt",
      }
      -- Builds a list of LSP server names to be installed
      local ensure_installed = vim.tbl_keys(servers or {})
      -- Append the formatters and linters to this list to be installed
      vim.list_extend(ensure_installed, lsp_tools)
      -- Initialize Mason for installing LSP servers
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      -- Ensure all LSP servers are installed
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      -- Set up all the LSP servers using Mason
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  -- { -- Autoformat
  --   "stevearc/conform.nvim",
  --   opts = {
  --     notify_on_error = false,
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       -- python = { "isort", "ruff_format" },
  --       python = function(bufnr)
  --         if require("conform").get_formatter_info("ruff_format", bufnr).available then
  --           return { "ruff_format" }
  --         else
  --           return { "isort", "black" }
  --         end
  --       end,
  --       javascript = { { "prettierd", "prettier" } },
  --       ansible = { "yamlfmt" },
  --       bash = { "shfmt" },
  --       markdown = { "markdownlint" },
  --     },
  --   },
  -- },
  { -- none-ls does auto formatting
    "nvimtools/none-ls.nvim",
    event = "BufRead",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.markdownlint,
        },
      })
    end,
  },

  { -- Completion
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "windwp/nvim-autopairs",
      -- snippet support
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        depedenencies = {
          "rafamadriz/friendly-snippets",
        },
        build = "make install_jsregexp",
        config = function()
          require("luasnip/loaders/from_vscode").lazy_load()
        end,
      },
      -- completion sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- completion icons
      "onsails/lspkind-nvim",
      -- copilot
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        -- sources for autocompletion
        sources = {
          -- { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "path" },
          -- { name = "luasnip" },
          -- { name = "copilot" },
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

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Statusline
    "hoob3rt/lualine.nvim",
    lazy = false,
    config = function()
      require("lualine").setup({
        options = {
          section_separators = "",
          component_separators = "",
          theme = vim.g.lualine_theme,
        },
      })
    end,
  },

  { -- Markdown preview
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

  { -- File tree
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

  { -- Treesitter!
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

  { -- Surround
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  { -- Trim whitespace
    "cappyzawa/trim.nvim",
    cmd = "Trim",
    opts = {},
  },

  { -- Creating matching tags automatically
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  { -- Debugger with DAP
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      -- Creates the debugger UI
      "rcarriga/nvim-dap-ui",
      -- Automated tests?
      "nvim-neotest/nvim-nio",
      -- Installs debug adapters
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
        -- Best effort setup of debuggers
        automatic_setup = true,
        ensure_installed = {
          "delve",
          "debugpy",
        },
      })

      -- Basic debugging keymaps
      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Set up debuggers
      require("dap-go").setup()
      require("dap-python").setup()
    end,
  },
})

--[[
===============================================================================
  _____                            _
 |  __ \                          | |
 | |  | |_   _ _ __ ___  _ __  ___| |_ ___ _ __
 | |  | | | | | '_ ` _ \| '_ \/ __| __/ _ \ '__|
 | |__| | |_| | | | | | | |_) \__ \ ||  __/ |
 |_____/ \__,_|_| |_| |_| .__/|___/\__\___|_|
                        | |
                        |_|
===============================================================================
--]]

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

-- {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       -- flavour = "frappe",
--       flavour = "macchiato",
--     })
--     vim.cmd.colorscheme("catppuccin")
--     vim.g.lualine_theme = "catppuccin"
--   end,
-- },

-- {
--   "Mofiqul/vscode.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vscode").setup({
--       italic_comments = true,
--     })
--     require("vscode").load()
--     vim.g.lualine_theme = "codedark"
--   end,
-- },

-- {
--   "loctvl842/monokai-pro.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("monokai-pro").setup()
--     vim.cmd.colorscheme("monokai-pro")
--     vim.g.lualine_theme = "monokai-pro"
--   end
-- },
--

-- vim: ts=2 sts=2 sw=2 et
