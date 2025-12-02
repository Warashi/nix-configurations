function on_attach_console(bufnr, info)
	local opts = { buffer = bufnr, nowait = true, silent = true }
	vim.keymap.set("n", "<C-c>", "<Plug>(aibo-send)<Esc>", opts)
	vim.keymap.set("n", "<C-l>", "<Plug>(aibo-send)<C-l>", opts)
	vim.keymap.set("n", "<CR>", "<Plug>(aibo-send)<CR>", opts)
	vim.keymap.set("n", "<C-n>", "<Plug>(aibo-send)<C-n>", opts)
	vim.keymap.set("n", "<C-p>", "<Plug>(aibo-send)<C-p>", opts)
	vim.keymap.set("n", "<Down>", "<Plug>(aibo-send)<Down>", opts)
	vim.keymap.set("n", "<Up>", "<Plug>(aibo-send)<Up>", opts)

	if info.cmd == "claude" then
		on_attach_console_claude(bufnr, info)
	elseif info.cmd == "codex" then
		on_attach_console_codex(bufnr, info)
	end
end

function on_attach_prompt(bufnr, _info)
	local _opts = { buffer = bufnr, nowait = true, silent = true }
end

function on_attach_console_claude(bufnr, _info)
	local opts = { buffer = bufnr, nowait = true, silent = true }
	vim.keymap.set("n", "<Tab>", "<Plug>(aibo-send)<Tab>", opts)
	vim.keymap.set("n", "<S-Tab>", "<Plug>(aibo-send)<S-Tab>", opts)
	vim.keymap.set("n", "<C-o>", "<Plug>(aibo-send)<C-o>", opts)
	vim.keymap.set("n", "<C-t>", "<Plug>(aibo-send)<C-t>", opts)
end

function on_attach_console_codex(bufnr, _info)
	local opts = { buffer = bufnr, nowait = true, silent = true }
	vim.keymap.set({ "n", "i" }, "<C-t>", "<Plug>(aibo-send)<C-t>", opts)
	vim.keymap.set({ "n", "i" }, "<C-u>", "<Plug>(aibo-send)<PageUp>", opts)
	vim.keymap.set({ "n", "i" }, "<C-d>", "<Plug>(aibo-send)<PageDown>", opts)
end

require("aibo").setup({
	prompt = {
		no_default_mappings = true,
		on_attach = on_attach_prompt,
	},
	console = {
		no_default_mappings = true,
		on_attach = on_attach_console,
	},
	tools = {
		claude = {
			no_default_mappings = true,
		},
		codex = {
			no_default_mappings = true,
		},
	},
})
