local function skkeleton_initialize()
	vim.fn["skkeleton#config"]({
		globalDictionaries = { "@skk_jisyo_l@" },
		markerHenkan = "",
		markerHenkanSelect = "",
	})

	-- skkeleton-state-pupup config
	vim.fn["skkeleton_state_popup#config"]({
		labels = {
			input = {
				hira = "あ",
				kata = "ア",
				hankata = "ｶﾅ",
				zenkaku = "Ａ",
			},
			["input:okurinasi"] = {
				hira = "▽▽",
				kata = "▽▽",
				hankata = "▽▽",
				abbrev = "ab",
			},
			["input:okuriari"] = {
				hira = "▽▽",
				kata = "▽▽",
				hankata = "▽▽",
			},
			henkan = {
				hira = "▼▼",
				kata = "▼▼",
				hankata = "▼▼",
				abbrev = "ab",
			},
			latin = "_A",
		},
		opts = {
			relative = "cursor",
			col = 0,
			row = 1,
			anchor = "NW",
			style = "minimal",
		},
	})

	vim.fn["skkeleton_state_popup#enable"]()

	vim.api.nvim_set_hl(0, "SkkeletonHenkan", {
		underline = true,
	})

	vim.api.nvim_set_hl(0, "SkkeletonHenkanSelect", {
		underline = true,
		reverse = true,
	})
end

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "skkeleton-initialize-pre" },
	callback = skkeleton_initialize,
})

vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)")

vim.fn["skkeleton#initialize"]()
