return {
	"neovim/nvim-lspconfig",
	event = "BufRead",
	dependencies = {
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
			cmd = "Mason",
			config = true,
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"jayp0521/mason-null-ls.nvim",
			},
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
						null_ls.builtins.formatting.shfmt,
						null_ls.builtins.formatting.prettier,
						null_ls.builtins.formatting.stylua,
					},
				})
			end,
		},
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			config = function()
				require("fidget").setup()
			end,
		},
		{
			"glepnir/lspsaga.nvim",
			config = function()
				require("lspsaga").setup({
					symbol_in_winbar = { enable = false },
					lightbulb = { enable = false },
					ui = { title = false },
				})
			end,
		},
		"ray-x/lsp_signature.nvim",
		"simrat39/rust-tools.nvim",
		"lvimuser/lsp-inlayhints.nvim",
	},
	config = function()
		------------------------------------------------------------------
		--   Keymaps
		------------------------------------------------------------------
		vim.api.nvim_create_augroup("LspAttach_keybinds", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "LspAttach_keybinds",
			callback = function()
				-- Vanilla LSP
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
					{ silent = true }
				)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { silent = true })
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>lua require('telescope.builtin').lsp_references()<cr>",
					{ silent = true }
				)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { silent = true })
				vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
				vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })
				vim.keymap.set(
					"n",
					"<leader>fs",
					"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
					{ silent = true }
				)
				vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { silent = true })
				vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { silent = true })
				vim.keymap.set("n", "<leader>lr", ":LspRestart<cr>", { silent = true })
				vim.keymap.set("n", "<leader>li", ":LspInfo<cr>", { silent = true })
				vim.keymap.set(
					"n",
					"<leader>lh",
					"<cmd>lua require('rust-tools').inlay_hints.toggle()<CR>",
					{ silent = true }
				)
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
			end,
		})

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
		--   Autoformatting
		------------------------------------------------------------------
		-- vim.api.nvim_create_augroup("LspAttach_formatting", {})
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	group = "LspAttach_formatting",
		-- 	callback = function(args)
		-- 		if not (args.data and args.data.client_id) then
		-- 			return
		-- 		end
		--
		-- 		local bufnr = args.buf
		-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 		if client.supports_method("textDocument/formatting") then
		-- 			vim.api.nvim_create_autocmd("BufWritePre", {
		-- 				buffer = bufnr,
		-- 				callback = function()
		-- 					vim.lsp.buf.format({ bufnr = bufnr })
		-- 				end,
		-- 			})
		-- 		end
		-- 	end,
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
		--   Mason
		------------------------------------------------------------------
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")

		mason.setup()
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
			},
		})

		mason_null_ls.setup({
			automatic_installation = true,
			ensure_installed = {
				"black",
				"jq",
				"shfmt",
				"markdownlint",
				"prettier",
			},
		})

		local lsp = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		------------------------------------------------------------------------------
		-- Any server that doesn't have specific configuration can go here
		------------------------------------------------------------------------------
		local basic_servers = {
			"rust_analyzer", -- rust
			"bashls", -- bash
			"cssls", -- css
			"html",
		}
		for _, server in ipairs(basic_servers) do
			lsp[server].setup({
				capabilities = lsp_capabilities,
			})
		end

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
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
					format = { enable = false },
				},
			},
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
