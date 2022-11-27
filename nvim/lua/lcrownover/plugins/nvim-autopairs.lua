require('nvim-autopairs').setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
