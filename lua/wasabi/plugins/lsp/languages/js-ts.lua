return {
	ts_ls = {
		init_options = {
			preferences = {
				disableSuggestions = false,
				quotePreference = "auto",
				includeCompletionsForModuleExports = true,
				includeCompletionsForImportStatements = true,
				includeCompletionsWithSnippetText = true,
				includeAutomaticOptionalChainCompletions = true,
			},
		},
		settings = {
			completions = {
				completeFunctionCalls = true
			},
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literal",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
				preferences = {
					importModuleSpecifier = "relative"
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
			},
		},
	},
}
