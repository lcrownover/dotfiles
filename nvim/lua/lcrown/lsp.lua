---------------------------------------
-- lspconfig
---------------------------------------

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

local lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end


-- Any server that doesn't have specific configuration can go here
local basic_servers = {
    "gopls",        -- golang
    "solargraph",   -- ruby
    "rust_analyzer",-- rust
    "tsserver",     -- typescript
    "bashls",       -- bash
    "vimls",        -- vim
    "puppet",       -- puppet
    "clangd",       -- c
    "cssls",        -- css
    "perlls",       -- perl
}
for _, server in ipairs(basic_servers) do
  lsp[server].setup { on_attach = custom_attach }
end


---------------------------------------
-- python
---------------------------------------

lsp['pyright'].setup {
  on_attach = custom_attach,
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
  on_attach = custom_attach,
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
USER = vim.fn.expand('$USER')

local sumneko_root_path = "/Users/" .. USER .. "/repos/lua-language-server"
local sumneko_binary = "/Users/" .. USER .. "/repos/lua-language-server/bin/macOS/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp['sumneko_lua'].setup {
  on_attach = custom_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
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
        globals = {'vim'},
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
  server = {on_attach = custom_attach},
})

---------------------------------------
-- terraform
---------------------------------------

lsp['terraformls'].setup{}

---------------------------------------
-- efm
---------------------------------------

lsp['efm'].setup {
  init_options = {documentFormatting = true},
  filetypes = {
    "lua",
    "python",
    "go",
    "json",
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      python = { {formatCommand = "black --quiet -", formatStdin = true} },
      lua = { {formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb", formatStdin = true} },
      json = { {formatCommand = "jq .", formatStdin = true} },
      go = { {formatCommand = "gofmt", formatStdin = true} },
      -- ruby: formatting is handled by solargraph
      -- rust: formatting is handled by rust_analyzer
    }
  }
}

---------------------------------------
-- lspkind
---------------------------------------

-- fancy symbols for completion
require('lspkind').init({
    -- enables text annotations
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    -- preset = 'codicons',
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

-- require "lsp_signature".setup()
