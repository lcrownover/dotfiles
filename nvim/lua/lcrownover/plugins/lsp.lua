-- LSP
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
        "fatih/vim-go",

        -- Additional lua configuration, makes nvim stuff amazing
        "folke/neodev.nvim",
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

        local lsp = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local on_attach = function(_, bufnr)
            require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                    border = "rounded",
                },
            }, bufnr)
        end

        -- pass capabilities into each lsp server
        local capabilities = cmp_nvim_lsp.default_capabilities()

        ------------------------------------------------------------------------------
        -- Any server that doesn't have specific configuration can go here
        ------------------------------------------------------------------------------
        local basic_servers = {
            "gopls", -- golang
            "solargraph", -- ruby
            "rust_analyzer", -- rust
            "tsserver", -- typescript
            "bashls", -- bash
            "vimls", -- vim
            "puppet", -- puppet
            "clangd", -- c
            "cssls", -- css
            "perlls", -- perl
            "html",
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
        -- lsp["ansiblels"].setup({
        --   on_attach = on_attach,
        --   capabilities = capabilities,
        --   filetypes = {
        --     "yaml.ansible",
        --     "yml",
        --     "yaml",
        --   },
        -- })

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
        lsp["sumneko_lua"].setup({
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
                    auto = true,
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
