return {
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
        "folke/neodev.nvim",
        "lvimuser/lsp-inlayhints.nvim",
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
        end

        local fmtgroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        local on_attach = function(client, bufnr)
            print("should print anywhere lsp attaches")
            require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                    border = "rounded",
                },
            }, bufnr)
            print("after lsp_signature")

            if client.supports_method("textDocument/formatting") then
                print("should set up formatting")
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = fmtgroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end

        -- pass capabilities into each lsp server
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- shortcut
        local lsp = require("lspconfig")

        ------------------------------------------------------------------------------
        -- Any server that doesn't have specific configuration can go here
        ------------------------------------------------------------------------------
        local basic_servers = {
            -- "solargraph",    -- ruby
            "rust_analyzer", -- rust
            -- "tsserver",      -- typescript
            "bashls",        -- bash
            -- "vimls",         -- vim
            -- "puppet",        -- puppet
            -- "clangd",        -- c
            "cssls", -- css
            -- "perlls",        -- perl
            "html",
            -- "svelte",
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
                "yml.ansible",
                "yml",
            },
        })

        ---------------------------------------
        -- golang
        ---------------------------------------
        set_fmt({ "*.go" }, 4, false)
        lsp["gopls"].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    staticcheck = true,
                },
            },
        }
        local golsp = vim.api.nvim_create_augroup("GoLSP", { clear = true, })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = golsp,
            pattern = "*.go",
            callback = function()
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>llr", ":!go run cmd/*/main.go<cr>", {})
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>llta", ":GoTagAdd<cr>", { silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>lltr", ":GoTagRm<cr>", { silent = true })
            end,
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
}
