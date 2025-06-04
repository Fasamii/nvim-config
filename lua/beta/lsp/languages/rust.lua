return {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true
					},
				},
				checkOnSave = {
					command = "clippy",      -- run `cargo clippy` instead of `cargo check`
					extraArgs = { "--workspace", "--", "-D", "warnings" },
				},
				procMacro    = { enable = true },
				diagnostics = {
					enable       = true,
					experimental = { enable = true },
				},
				hover = { actions = { enable = true } },
				inlayHints = {
					bindingModeHints = {
						enable = false,
					},
					chainingHints = {
						enable = true,
					},
					closingBraceHints = {
						enable = true,
						minLines = 25,
					},
					closureReturnTypeHints = {
						enable = "always",
					},
					lifetimeElisionHints = {
						enable = "always",
						useParameterNames = false,
					},
					maxLength = 25,
					parameterHints = {
						enable = true,
					},
					reborrowHints = {
						enable = "never",
					},
					renderColons = true,
					typeHints = {
						enable = true,
						hideClosureInitialization = false,
						hideNamedConstructor = false,
					},
				},
			},
		},
	},
}
