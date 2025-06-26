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
					command = "clippy",
					extraArgs = {
						"--",
						"-Wclippy::pedantic", -- strict (good for clean code)
						"-Wclippy::nursery", -- experimental lints
						"-Wclippy::cargo", -- warn about Cargo.toml issues
						"-Wclippy::indexing_slicing", -- warn on .index() or [] that could panic
						"-Wclippy::unwrap_used", -- warn when .unwrap() is used
						"-Wclippy::expect_used", -- warn when .expect() is used
						"-Wclippy::panic", -- warn when panic!() is used
						"-Wclippy::todo", -- warn on todo!() macros
					},
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
