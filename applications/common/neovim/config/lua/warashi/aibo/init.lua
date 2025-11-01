require("aibo").setup({
	tools = {
		claude = {
			no_default_mappings = true,
			on_attach = function(bufnr, info) end,
		},
		codex = {
			no_default_mappings = true,
			on_attach = function(bufnr, info) end,
		},
	},
})
