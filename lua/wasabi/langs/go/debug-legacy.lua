local M = {}
M.filetypes = { "go" }
M.extensions = { "go" }

-- Dependencies specific to Go debugging
M.dependencies = {
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				delve = {
					path = "dlv",
					initialize_timeout_sec = 20,
					port = "${port}",
					args = {},
					build_flags = "",
				},
			})

			-- Go-specific keymaps
			vim.keymap.set('n', '<leader>dt', function()
				require("dap-go").debug_test()
			end, { desc = 'Debug: Test (Go)' })

			vim.keymap.set('n', '<leader>dT', function()
				require("dap-go").debug_last_test()
			end, { desc = 'Debug: Last Test (Go)' })
		end,
	}
}

-- Setup function called by the main debug config
function M.setup(dap)
	-- Check if delve is installed
	if vim.fn.executable("dlv") == 0 then
		vim.notify(
		"Delve (dlv) not found. Please install it with: go install github.com/go-delve/delve/cmd/dlv@latest",
			vim.log.levels.WARN)
		return
	end

	-- Go adapter configuration
	dap.adapters.go = function(callback, config)
		local stdout = vim.loop.new_pipe(false)
		local handle
		local pid_or_err
		local port = 38697

		local opts = {
			stdio = { nil, stdout },
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true
		}

		handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
			stdout:close()
			handle:close()
			if code ~= 0 then
				print('dlv exited with code', code)
			end
		end)

		assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))

		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if not chunk then
				stdout:close()
				return
			end
			if chunk:find("API server listening at") then
				callback({
					type = "server",
					host = "127.0.0.1",
					port = port
				})
			end
		end)
	end

	-- Go configurations
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}"
		},
		{
			type = "go",
			name = "Debug (Arguments)",
			request = "launch",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
		},
		{
			type = "go",
			name = "Debug Package",
			request = "launch",
			program = "${fileDirname}"
		},
		{
			type = "go",
			name = "Attach",
			mode = "local",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
		{
			type = "go",
			name = "Debug test",
			request = "launch",
			mode = "test",
			program = "${file}"
		},
		{
			type = "go",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		}
	}
end

return M
