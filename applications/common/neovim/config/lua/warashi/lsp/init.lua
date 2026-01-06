-- keep-sorted start
vim.lsp.enable("copilot")
vim.lsp.enable("denols")
vim.lsp.enable("emmylua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("moonbit")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("sourcekit")
vim.lsp.enable("tsp_server")
-- keep-sorted end

vim.fn["signature_help#enable"]()
vim.fn["popup_preview#enable"]()

vim.diagnostic.handlers.loclist = {
	show = function(_, _, _, opts)
		-- Generally don't want it to open on every update
		opts.loclist.open = opts.loclist.open or false
		local winid = vim.api.nvim_get_current_win()
		vim.diagnostic.setloclist(opts.loclist)
		vim.api.nvim_set_current_win(winid)
	end,
}

vim.diagnostic.config({
	loclist = {
		open = true,
		severity = { min = vim.diagnostic.severity.HINT },
	},
})
