vim.o.clipboard = "unnamedplus"
vim.opt.runtimepath:prepend("@merged_plugins@")
vim.opt.runtimepath:prepend(vim.env.HOME .. "/ghq/github.com/Warashi/skkbit")
vim.opt.termguicolors = true

-- keep-sorted start
require("warashi.aibo")
require("warashi.ddc")
require("warashi.lsp")
require("warashi.skkeleton")
require("warashi.terminal")
require("warashi.treesitter")
-- keep-sorted end

vim.cmd.colorscheme("catppuccin-frappe")
