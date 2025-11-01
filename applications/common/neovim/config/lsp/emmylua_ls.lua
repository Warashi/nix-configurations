return {
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				ignoreDir = {
					".vscode",
					".direnv",
				},
				checkThirdParty = false,
			},
		},
	},
	workspace_required = true,
}
