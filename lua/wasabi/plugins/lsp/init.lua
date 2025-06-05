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
		capabilities.textDocument.completion.completionItem.snippetSupport = true;
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" }
		};

		local servers = {};


		local current_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:match("@(.+)"), ":h");
		local langs_dir = current_dir .. "/languages";
		local files = vim.fn.glob(langs_dir .. "/*.lua", false, true);

		if vim.fn.isdirectory(langs_dir) == 0 then
			notify("Lang directory not found at " .. langs_dir .. " (using defaults)", vim.log.levels.ERROR);
		else
			for _, file_path in ipairs(files) do
				local ok, config = pcall(dofile, file_path);
				if ok and type(config) == "table" then
					for server_name, server_config in pairs(config) do
						if type(server_config) == "table" then
							servers[server_name] = server_config;
						else
							notify(
								"expected <table>, got <" .. type(server_config) .. "> at [" ..
								file_path .. "]",
								vim.log.levels.ERROR);
						end
					end
				else
					notify(
						"expected <table>, got <" .. type(config) .. "> at [" .. file_path .. "]",
						vim.log.levels.ERROR);
				end
			end
			if vim.tbl_isempty(servers) then
				notify("Failed to retrive ls server configs, (using defaults)", vim.log.levels.WARN);
			else
				for server, config in pairs(servers) do
					local server_config = vim.tbl_deep_extend("force", {
						on_attach = on_attach,
						capabilities = capabilities,
					}, config);
					vim.lsp.config[server] = server_config;
				end
			end
			for server, _ in pairs(servers) do
				local ok, err = pcall(vim.lsp.enable, server);
				if not ok then
					notify("Failed to enable [" .. server .. "] (" .. tostring(err) .. ")", vim.log.level
						.ERROR);
				end
			end
		end
	end
} }
