return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-Right>",
          dismiss = "<C-Left>",
        },
      },
      filetypes = {
        yaml = true,
      },
    })
  end,
}
