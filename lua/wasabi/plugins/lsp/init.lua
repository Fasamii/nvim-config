return {
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "$3rd/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
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
	},
	{
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
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/lazydev.nvim" },
		},
		config = function()
			-- TODO: make single global notify foo and require it here
			local notify = function(msg, ll)
				local ok, fidget = pcall(require, "fidget");
				if ok then
					fidget.notify(msg, ll);
				else
					vim.notify(msg, ll);
				end
			end

			local on_attach = function(client, bufnr)
				require("wasabi.keymaps").lsp(client, bufnr);
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc";
				if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr });
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities();
			local ok, blink = pcall(require, "blink.cmp");
			if ok then capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities()); end

			local lsp_root_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:match("@(.+)"), ":h");
			local lsp_langs_dir = lsp_root_dir .. "/languages";
			local lsp_ls_config_files = vim.fn.glob(lsp_langs_dir .. "/*.lua", false, true);

			if vim.fn.isdirectory(lsp_langs_dir) == 0 then
				notify("Lang directory not found at " .. lsp_langs_dir .. " (using defaults)",
					vim.log.levels.ERROR);
				-- TODO: add fallback lsp enabling functionality
				-- TEST: test how lsp is behaving on fallback
			else
				for _, lsp_ls_config_file in ipairs(lsp_ls_config_files) do
					local ok, config = pcall(dofile, lsp_ls_config_file);
					if not ok or not type(config) == "table" then
						notify(
							"expected <table>, got <" ..
							type(config) .. "> at [" .. lsp_ls_config_file .. "]",
							vim.log.levels.ERROR);
					else
						for ls_name, ls_config in pairs(config) do
							if not type(ls_config) == "table" then
								notify(
									"expected <table>, got <" ..
									type(ls_config) .. "> at [" .. lsp_ls_config_file .. "]",
									vim.log.levels.ERROR);
							else
								vim.lsp.config[ls_name] = vim.tbl_deep_extend(
									"force", ls_config, {
										on_attach = on_attach,
										capabilities = capabilities,
									});
								local enabled, enable_err = pcall(vim.lsp.enable, ls_name);
								if not enabled then
									notify(
										"Failed to enable [" ..
										ls_name .. "] (" .. tostring(enable_err) .. ")",
										vim.log.level.ERROR);
								end
							end
						end
					end
				end
			end
		end
	}
}
