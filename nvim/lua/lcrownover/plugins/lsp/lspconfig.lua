-- helper for quickly setting format override options per-language
local set_fmt = function(file_patterns, indent_length, expandtab)
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = file_patterns,
    callback = function()
      if expandtab then vim.opt.expandtab = true else vim.opt.expandtab = false end
      vim.opt.tabstop = indent_length
      vim.opt.shiftwidth = indent_length
    end
  })
end

local lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = vim.keymap -- concise

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- lsp keymaps
  keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  keymap.set('n', '<leader>fs', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- lspsaga remaps
  keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "gs", "<cmd>Lspsaga peek_definition<CR>", opts)
  -- jump diagnostic
  keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  -- or jump to error
  keymap.set("n", "[E",
    function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    opts)
  keymap.set("n", "]E",
    function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    opts)
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
set_fmt({ "*.go" }, 4, false)
-- disable "K" in vim-go
vim.g.go_doc_keywordprg_enabled = 0


---------------------------------------
-- ruby
---------------------------------------
set_fmt({ "*.rb", "*.pp" }, 2, true)
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
set_fmt({ "*.lua" }, 2, true)
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
require('rust-tools').setup({
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
lsp['terraformls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "terraform",
    "tf",
  },
}


---------------------------------------
-- typescript/javascript
---------------------------------------
set_fmt({ "*.ts", "*.js", "*.jsx" }, 2, true)


---------------------------------------
-- markdown
---------------------------------------
set_fmt({ "*.md" }, 2, true)
