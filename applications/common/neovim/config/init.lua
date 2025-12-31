vim.o.clipboard = "unnamedplus"
vim.opt.runtimepath:prepend("@merged_plugins@")
vim.opt.termguicolors = true

-- keep-sorted start
require("warashi.aibo")
require("warashi.ddc")
require("warashi.lsp")
require("warashi.moonbit")
require("warashi.skkeleton")
require("warashi.terminal")
-- keep-sorted end

vim.cmd.colorscheme("retrobox")
