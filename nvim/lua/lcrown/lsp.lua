-- lspkind shows icons for sources
local lspkind = require('lspkind')

-- fidget gives a cool loading status for lsp
require "fidget".setup {}

---------------------------------------
-- nvim-cmp (completion)
---------------------------------------

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

local cmp = require("cmp")
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = false,
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


---------------------------------------
-- lspconfig
---------------------------------------

vim.o.shortmess = vim.o.shortmess .. "c"

local lsp = require('lspconfig')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    -- lsp remaps
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.keymap.set('n', '<leader>fs', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
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
    }
end


---------------------------------------
-- python
---------------------------------------

lsp['pyright'].setup {
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = false,
      }
    }
  }
}

---------------------------------------
-- ruby
---------------------------------------

lsp['solargraph'].setup {
  on_attach = on_attach,
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
local sumneko_root_path = os.getenv("HOME") .. "/repos/lua-language-server"
local sumneko_binary = os.getenv("HOME") .. "/repos/lua-language-server/bin/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp['sumneko_lua'].setup {
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
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
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = { on_attach = on_attach },
})

---------------------------------------
-- terraform
---------------------------------------

lsp['terraformls'].setup {
  on_attach = on_attach,
  filetypes = {
    "terraform",
    "tf",
  },
}


---------------------------------------
-- ansible
---------------------------------------

-- lsp['ansiblels'].setup {
--   on_attach = on_attach,
--   filetypes = {
--     "yml",
--     "yaml",
--     "yml.ansible",
--     "yaml.ansible",
--   },
--   settings = {
--     rootMarkers = { ".git/" },
--     ansible = {
--       python = {
--         interpreterPath = "python3"
--       }
--     }
--   }
-- }

---------------------------------------
-- null-ls
---------------------------------------
local null_ls = require 'null-ls'
null_ls.setup({
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.tidy,
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.code_actions.xo,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.ansiblelint.with({
        filetypes = {"yaml","yml","yaml.ansible","yml.ansible"},
      }),
    },
})


---------------------------------------
-- lspkind
---------------------------------------

-- fancy symbols for completion
require('lspkind').init({
    -- enables text annotations
    mode = true,
    preset = 'default',

    -- override preset symbols
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

-- trouble (quickfix for errors and lsp stuff)
require("trouble").setup {}

-- autopairs config
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})
