vim.o.clipboard = "unnamedplus"
vim.opt.runtimepath:prepend("@merged_plugins@")
vim.opt.termguicolors = true

require("warashi.aibo")
require("warashi.ddc")
require("warashi.lsp")
require("warashi.skkeleton")
require("warashi.terminal")

vim.cmd.colorscheme("retrobox")
