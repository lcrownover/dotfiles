---------------------------------------
-- nvim-cmp (completion)
---------------------------------------

-- lspkind shows icons for sources
local lspkind = require('lspkind')

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

local cmp = require("cmp")
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
    })
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  min_length = 0, -- allow for `from package import _` in Python
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()


---------------------------------------
-- lspconfig
---------------------------------------

vim.o.shortmess = vim.o.shortmess .. "c"

local lsp = require('lspconfig')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  -- lsp remaps
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '<leader>fs', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- lspsaga remaps
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "gs", "<cmd>Lspsaga peek_definition<CR>", opts)
  -- jump diagnostic
  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  -- or jump to error
  vim.keymap.set("n", "[E",
    function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    opts)
  vim.keymap.set("n", "]E",
    function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    opts)
end


-- Any server that doesn't have specific configuration can go here
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
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


---------------------------------------
-- python
---------------------------------------

lsp['pyright'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = false,
      }
    }
  }
}

---------------------------------------
-- golang
---------------------------------------

-- setup is handled in the basic servers
-- but we want to set expandtab for golang
local set_golang_fmt = function()
  vim.opt.expandtab = false
end
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.go",
  callback = set_golang_fmt,
})
-- disable "K" in vim-go
vim.g.go_doc_keywordprg_enabled = 0


---------------------------------------
-- ruby
---------------------------------------

lsp['solargraph'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    solargraph = {
      formatting = true,
    }
  }
}

---------------------------------------
-- lua
---------------------------------------
lsp['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'require' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}


---------------------------------------
-- rust
---------------------------------------

-- rust-tools configures rust_analyzer for us
require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  tools = {
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
})

---------------------------------------
-- terraform
---------------------------------------

lsp['terraformls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "terraform",
    "tf",
  },
}


---------------------------------------
-- null-ls
---------------------------------------
local null_ls = require 'null-ls'
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.blue,
    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.beautysh,
  },
})
