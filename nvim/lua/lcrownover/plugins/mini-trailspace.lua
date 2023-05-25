return {
  'echasnovski/mini.trailspace',
  config = function()
    require('mini.trailspace').setup()

    vim.api.nvim_create_autocmd(
      "BufWritePre", {
        pattern = "*",
        callback = function()
          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end,
      }
    )
  end
}
