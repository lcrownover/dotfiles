return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  keys = {
    { "gh",   "<cmd>Lspsaga lsp_finder<CR>" },
    { "K",    "<cmd>Lspsaga hover_doc<CR>" },
    { "gn",   "<cmd>Lspsaga rename<CR>" },
    { "<F2>", "<cmd>Lspsaga rename<CR>" },
    { "gs",   "<cmd>Lspsaga peek_definition<CR>" },
    { "[e",   "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    { "]e",   "<cmd>Lspsaga diagnostic_jump_next<CR>" },
    {
      "[E",
      function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
    },
    {
      "]E",
      function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
    },
  },
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        title = false,
      },
    })
  end,
}
