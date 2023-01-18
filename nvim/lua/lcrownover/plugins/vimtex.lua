return {
  {
    "lervag/vimtex",
    ft = "tex",
    config = function ()
      vim.g.vimtex_view_method = 'zathura'
      vim.api.nvim_create_user_command("OpenZathuraPDF", function()
        -- vim.cmd[[execute "normal \<Plug>(vimtex-compile)"]]
        local current_filepath = vim.fn.expand('%:p')
        local pdf_filepath = string.gsub(current_filepath, ".tex", ".pdf")
        io.popen(string.format("zathura %s &", pdf_filepath))
      end, {})
      -- vim.api.nvim_create_autocmd("BufWritePost", {
      --   pattern = "*.tex",
      --   callback = function()
      --     -- vim.fn('<Plug>(vimtex-compile)')
      --   end
      -- })
    end
  }
}
