return {
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "strict", -- Changed from "basic" for better type checking
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					autoImportCompletions = true,
					diagnosticMode = "workspace", -- Check entire workspace
					stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
				},
			},
		},
	},
}
