local function skkeleton_initialize()
	vim.fn["skkeleton#config"]({
		showCandidatesCount = 1,
		globalDictionaries = { "@skk_jisyo_l@" },
	})
end

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "skkeleton-initialize-pre" },
	callback = skkeleton_initialize,
})

vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)")

vim.fn["skkeleton#initialize"]()
