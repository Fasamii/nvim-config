return { {
	"b0o/schemastore.nvim",
	lazy = true,
}, {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "$3rd/luv/library", words = { "vim%.uv" } },
		},
	},
}, {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	opts = {
		ui = {
			icons = {
				package_installed = " ",
				package_pending = "󰾟 ",
				package_uninstalled = "󰅗 ",
			},
		},
	},
	config = function(_, opts)
		require("mason").setup(opts);
	end,
}, {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = {
			"clangd",
			"bashls",
			"lua_ls",
			"rust_analyzer",
			"gopls",
			"pyright",
			"ts_ls",
			"html",
			"cssls",
			"taplo",
			"jsonls",
			"yamlls",
			"marksman",
		},
		automatic_installation = true,
		handlers = {},
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts);
	end,
}, {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "folke/lazydev.nvim" },
	},
	config = function()
		local on_attach = function(client, bufnr)
			require("wasabi.keymaps").lsp(client, bufnr);
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc";
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities();
		capabilities.textDocument.completion.completionItem.snippetSupport = true;
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" }
		};

		local servers = {
			-- Lua
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

			-- Python
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

			-- TypeScript/JavaScript
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

			-- Rust
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = {
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
						},
						diagnostics = {
							enable = true,
							experimental = {
								enable = true,
							},
						},
						hover = {
							actions = {
								enable = true,
							},
						},
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
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
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

			-- Go
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			},

			-- C/C++
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			},

			-- HTML
			html = {
				filetypes = { "html", "htmx" },
				settings = {
					html = {
						format = {
							templating = true,
							wrapLineLength = 120,
							wrapAttributes = "auto",
						},
						hover = {
							documentation = true,
							references = true,
						},
					},
				},
			},

			-- CSS
			cssls = {
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					less = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},

			-- JSON
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
						format = { enable = true },
					},
				},
			},

			-- YAML
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
						validate = true,
						format = { enable = true },
						hover = true,
						completion = true,
						customTags = {
							"!fn",
							"!And",
							"!If",
							"!Not",
							"!Equals",
							"!Or",
							"!FindInMap sequence",
						},
					},
				},
			},

			-- TOML
			taplo = {
				settings = {
					taplo = {
						configFile = {
							enabled = true,
						},
					},
				},
			},

			-- Markdown
			marksman = {
				settings = {
					marksman = {
						completion = {
							wiki = {
								style = "title",
							},
						},
					},
				},
			},

			-- Bash
			bashls = {
				settings = {
					bashIde = {
						globPattern = "**/*@(.sh|.inc|.bash|.command)",
					},
				},
			},
		};

		for server, config in pairs(servers) do
			local server_config = vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, config)
			vim.lsp.config[server] = server_config
		end
		-- Enable LSP servers
		for server, _ in pairs(servers) do
			local ok, err = pcall(vim.lsp.enable, server);
			if not ok then
				vim.notify("Failed to enable LSP server:" .. server .. " - " .. err, vim.log.levels.ERROR);
			end
		end
	end
} }
