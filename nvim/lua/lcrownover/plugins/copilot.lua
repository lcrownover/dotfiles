return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "]c",
          dismiss = "[c",
        },
      },
      filetypes = {
        yaml = true,
      },
    })
  end,
}
