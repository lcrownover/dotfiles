
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all the base vim options
require("lcrownover.core.options")

-- Load all the plugins
require("lazy").setup("lcrownover.plugins")

-- Finish off with keymaps
require("lcrownover.core.keymaps")

-- just for testing
-- require('lcrownover.core.playground')

