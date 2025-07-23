local function enable_configs(configs)
	for name, config in pairs(configs) do
		print(name);
	end
end

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

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.c",
				callback = function()
					vim.bo.filetype = "c"
				end,
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.h",
				callback = function()
					-- You might want to set this to "c" if your headers are C
					vim.bo.filetype = "c"
				end,
			})

			local notify = require("wasabi.utils").notify;

			local on_attach = function(client, bufnr)
				require("wasabi.keymaps").lsp(client, bufnr);
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc";
				if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr });
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities();
			local ok, blink = pcall(require, "blink.cmp");
			if ok then
				capabilities = vim.tbl_deep_extend(
					"force",
					capabilities,
					blink.get_lsp_capabilities()
				);
			end

			local files = require("wasabi.langs").get_config_files("lsp");
			for _, servers in pairs(files) do
				for server_name, server_config in pairs(servers) do
					if not type(server_config) == "table" then
						notify(
							"expected <table>, got <" .. type(server_config) .. ">",
							vim.log.levels.ERROR,
							"lsp/init.lua"
						);
					else
						vim.lsp.config[server_name] = vim.tbl_deep_extend("force", server_config, {
							on_attach = on_attach,
							capabilities = capabilities,
						});
						local enabled, err = pcall(vim.lsp.enable, server_name);
						if not enabled then
							notify(
								"Failed to enable <" .. server_name .. ">\n<" .. tostring(err) .. ">",
								vim.log.level.ERROR,
								"lsp/init.lua"
							);
						end
					end
				end
			end
		end
	}
}
