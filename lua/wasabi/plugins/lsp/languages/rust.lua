return {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo       = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true
					},
				},
				checkOnSave = {
					enable = true,
				},
				procMacro   = { enable = true },
				diagnostics = {
					enable       = true,
					experimental = { enable = true },
				},
				hover       = { actions = { enable = true } },
				inlayHints  = {
					enable = true,
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
						enable = "never", -- or "always" or "with_block"
					},
					discriminantHints = {
						enable = "never", -- or "always" or "fieldless"
					},
					expressionAdjustmentHints = {
						enable = "never", -- or "always" or "reborrow"
					},
					implicitDrops = {
						enable = false,
					},
					lifetimeElisionHints = {
						enable = "never", -- or "always" or "skip_trivial"
						useParameterNames = false,
					},
					maxLength = 25,
					parameterHints = {
						enable = true,
					},
					reborrowHints = {
						enable = "never", -- or "always" or "mutable"
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
