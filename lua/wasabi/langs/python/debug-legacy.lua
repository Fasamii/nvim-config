local M = {}

M.filetypes = { "python" }
M.extensions = { "py", "pyw" }

-- Dependencies specific to Python debugging
M.dependencies = {
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local dap_python = require("dap-python")

			-- Try to find Python executable
			local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
			if python_path == "" then
				vim.notify("Python executable not found. Please install Python.", vim.log.levels.WARN)
				return
			end

			-- Setup dap-python
			dap_python.setup(python_path)

			-- Python-specific keymaps
			vim.keymap.set('n', '<leader>dn', function()
				dap_python.test_method()
			end, { desc = 'Debug: Test Method (Python)' })

			vim.keymap.set('n', '<leader>df', function()
				dap_python.test_class()
			end, { desc = 'Debug: Test Class (Python)' })

			vim.keymap.set('v', '<leader>ds', function()
				dap_python.debug_selection()
			end, { desc = 'Debug: Selection (Python)' })
		end,
	}
}

-- Setup function called by the main debug config
function M.setup(dap)
	-- Python adapter configuration
	dap.adapters.python = function(cb, config)
		if config.request == 'attach' then
			---@diagnostic disable-next-line: undefined-field
			local port = (config.connect or config).port
			---@diagnostic disable-next-line: undefined-field
			local host = (config.connect or config).host or '127.0.0.1'
			cb({
				type = 'server',
				port = assert(port, '`connect.port` is required for a python `attach` configuration'),
				host = host,
				options = {
					source_filetype = 'python',
				},
			})
		else
			cb({
				type = 'executable',
				command = vim.fn.exepath("python3") or vim.fn.exepath("python"),
				args = { '-m', 'debugpy.adapter' },
				options = {
					source_filetype = 'python',
				},
			})
		end
	end

	-- Python configurations
	dap.configurations.python = {
		{
			type = 'python',
			request = 'launch',
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python")
			end,
		},
		{
			type = 'python',
			request = 'launch',
			name = "Launch file with arguments",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python")
			end,
		},
		{
			type = 'python',
			request = 'attach',
			name = 'Attach remote',
			connect = function()
				local host = vim.fn.input('Host [127.0.0.1]: ')
				host = host ~= '' and host or '127.0.0.1'
				local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
				return { host = host, port = port }
			end,
		},
		{
			type = 'python',
			request = 'launch',
			name = 'Launch Django',
			program = vim.fn.getcwd() .. '/manage.py',
			args = {
				'runserver',
				'--noreload',
			},
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python")
			end,
			django = true,
		},
		{
			type = 'python',
			request = 'launch',
			name = 'Launch Flask',
			module = 'flask',
			env = {
				FLASK_APP = 'app.py',
				FLASK_ENV = 'development',
			},
			args = {
				'run',
				'--no-debugger',
				'--no-reload',
			},
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python")
			end,
		},
	}
end

return M
