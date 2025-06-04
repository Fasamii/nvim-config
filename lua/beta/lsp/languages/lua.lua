return  {
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
				completion = {
					callSnippet = "Replace"
				},
				hint = {
					enable = true,
					arrayIndex = "Disable", -- Don't show array index hints
					await = true,
					paramName = "Disable",
					paramType = true,
					semicolon = "Disable",
					setType = false,
				},
			},
		},
	},
}
