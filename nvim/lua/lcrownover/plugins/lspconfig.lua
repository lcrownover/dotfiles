return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      config = function()
        require("fidget").setup()
      end,
    },
    -- {
    --   "glepnir/lspsaga.nvim",
    --   config = function()
    --     require("lspsaga").setup({
    --       symbol_in_winbar = { enable = false },
    --       lightbulb = { enable = false },
    --       ui = { title = false },
    --     })
    --   end,
    -- },
    "ray-x/lsp_signature.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    {
      "simrat39/rust-tools.nvim",
      ft = "rust",
    },
  },
  config = function()
    ------------------------------------------------------------------
    --   Keymaps
    ------------------------------------------------------------------
    vim.keymap.set("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", { silent = true })
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { silent = true })
    vim.keymap.set("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", { silent = true })
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { silent = true })
    vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })
    vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { silent = true })
    vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { silent = true })
    vim.keymap.set("n", "<leader>lr", ":LspRestart<cr>", { silent = true })
    vim.keymap.set("n", "<leader>li", ":LspInfo<cr>", { silent = true })
    vim.keymap.set("n", "<leader>lh", "<cmd>lua require('rust-tools').inlay_hints.toggle()<CR>", { silent = true })
    -- Lspsaga
    vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>", { silent = true })
    vim.keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })
    vim.keymap.set("n", "gs", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    ------------------------------------------------------------------
    --   Inlay Hints
    ------------------------------------------------------------------
    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = "LspAttach_inlayhints",
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr)
      end,
    })

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

    local lsp = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    ---------------------------------------
    -- rust
    ---------------------------------------
    lsp["rust_analyzer"].setup({
      capabilities = lsp_capabilities,
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
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>llr", ":!go run cmd/*/main.go<cr>", {})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>llta", ":GoTagAdd<cr>", { silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>lltr", ":GoTagRm<cr>", { silent = true })
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
}
