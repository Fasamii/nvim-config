local M = {}

M.filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
M.extensions = { "js", "ts", "jsx", "tsx", "mjs", "cjs" }

-- Dependencies specific to JavaScript/TypeScript debugging
M.dependencies = {
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				name = "vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
				version = "1.*",
			}
		}
	}
}

-- Setup function called by the main debug config
function M.setup(dap)
	-- JavaScript/TypeScript adapter
	local js_debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug";

	if vim.fn.isdirectory(js_debug_path) == 1 then
		-- Node.js adapter
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { js_debug_path .. "/out/src/debugServerMain.js", "${port}" },
			}
		}

		-- Chrome adapter
		dap.adapters["pwa-chrome"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { js_debug_path .. "/out/src/debugServerMain.js", "${port}" },
			}
		}
	else
		vim.notify("vscode-js-debug not found. Please run :Lazy build vscode-js-debug", vim.log.levels.WARN)
	end

	-- JavaScript configurations
	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch with arguments",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome",
			url = function()
				local url = vim.fn.input("URL: ", "http://localhost:3000")
				return url
			end,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug npm script",
			runtimeExecutable = "npm",
			runtimeArgs = function()
				local script = vim.fn.input("npm script: ", "start")
				return { "run-script", script }
			end,
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}

	-- TypeScript configurations (inherit from JavaScript)
	dap.configurations.typescript = dap.configurations.javascript
	dap.configurations.javascriptreact = dap.configurations.javascript
	dap.configurations.typescriptreact = dap.configurations.javascript
end

return M
