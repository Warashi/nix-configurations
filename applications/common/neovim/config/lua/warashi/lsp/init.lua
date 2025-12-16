-- keep-sorted start
vim.lsp.enable("copilot")
vim.lsp.enable("emmylua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("sourcekit")
-- keep-sorted end

vim.fn["signature_help#enable"]()
vim.fn["popup_preview#enable"]()
