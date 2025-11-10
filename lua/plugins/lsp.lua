vim.lsp.config.rust_analyzer = {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
				extraArgs = {
					"--all-targets",
					"--all-features",
					"--",
					"-W",
					"clippy::pedantic",
					"-W",
					"clippy::nursery",
					"-W",
					"clippy::unwrap_used",
					"-W",
					"clippy::expect_used",
				},
			},
			checkOnSave = {
				enable = true,
				command = "clippy",
				extraArgs = {
					"--all-targets",
					"--all-features",
					"--",
					"-W",
					"clippy::pedantic",
					"-W",
					"clippy::nursery",
					"-W",
					"clippy::unwrap_used",
					"-W",
					"clippy::expect_used",
				},
			},
			diagnostics = {
				enable = true,
				enableExperimental = true,
				disabled = {},
				warningsAsHint = {},
				warningsAsInfo = {},
			},
			cargo = {
				allFeatures = true,
			},
			procMacro = {
				enable = true,
			},
			completion = {
				postfix = {
					enable = true,
				},
				autoimport = {
					enable = true,
				},
			},
			inlayHints = {
				enable = true,
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = false,
					minLines = 10,
				},
				closureReturnTypeHints = {
					enable = "always",
				},
				lifetimeElisionHints = {
					enable = "skip_trivial",
					useParameterNames = true,
				},
				parameterHints = {
					enable = false,
				},
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			workspace = {
				symbol = {
					search = {
						kind = "all_symbols",
					},
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
}
