return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", silent = true },
      { "<leader>dc", ":lua require'dap'.continue()<cr>",          silent = true },
      { "<leader>di", ":lua require'dap'.step_into()<cr>",         silent = true },
      { "<leader>du", ":lua require'dap'.step_out()<cr>",          silent = true },
      { "<leader>do", ":lua require'dap'.step_over()<cr>",         silent = true },
      { "<leader>dg", ":lua require'dapui'.toggle()<cr>",          silent = true },
      { "<F5>",       ":lua require'dap'.continue()<CR>",          silent = true },
      { "<F6>",       ":lua require'dapui'.toggle()<CR>",          silent = true },
      { "<F10>",      ":lua require'dap'.step_over()<CR>",         silent = true },
      { "<F11>",      ":lua require'dap'.step_into()<CR>",         silent = true },
      { "<F12>",      ":lua require'dap'.step_out()<CR>",          silent = true },
    },
  }
}
