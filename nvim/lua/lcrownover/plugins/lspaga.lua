return {
  "glepnir/lspsaga.nvim",
  branch = "main",
  keys = {
    -- lspsaga remaps
    { "gh", "<cmd>Lspsaga lsp_finder<CR>" },
    { "K", "<cmd>Lspsaga hover_doc<CR>" },
    { "gn", "<cmd>Lspsaga rename<CR>" },
    { "<F2>", "<cmd>Lspsaga rename<CR>" },
    { "gs", "<cmd>Lspsaga peek_definition<CR>" },
    -- jump diagnostic
    { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>" },
    -- or jump to error
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
      code_action_lightbulb = {
        enable = false,
      },
      -- keybinds for navigation in lspsaga window
      move_in_saga = { prev = "<C-k>", next = "<C-j>" },
      -- use enter to open file with finder
      finder_action_keys = {
        open = "<CR>",
      },
      -- use enter to open file with definition preview
      definition_action_keys = {
        edit = "<CR>",
      },
    })
  end,
}
