return {
	extensions = { "c", "h" },

	keymaps = {
		run_1 = {
			desc = "Compile C code",
			callback = function ()
				print("used function to compile c code without implementation yet (test foo)");
			end
		},
		run_2 = nil,
		run_3 = nil,
	},

	adapters = {
		gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		},
		codelldb = {
			type = 'server',
			port = "${port}",
			executable = {
				command = vim.fn.exepath("codelldb") or "codelldb",
				args = { "--port", "${port}" },
			},
		},
	},

	configurations = {
		{
			name = "Launch (GDB)",
			type = "gdb",
			request = "launch",
			program = function(dap)
				local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return (path and path ~= "") and path or dap.ABORT
			end,
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
		},
		{
			name = "Launch with arguments (GDB)",
			type = "gdb",
			request = "launch",
			program = function(dap)
				local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return (path and path ~= "") and path or dap.ABORT
			end,
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
		},
		{
			name = "Attach to process (GDB)",
			type = "gdb",
			request = "attach",
			pid = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		-- CodeLLDB configurations (if available)
		{
			name = "Launch (CodeLLDB)",
			type = "codelldb",
			request = "launch",
			program = function(dap)
				local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return (path and path ~= "") and path or dap.ABORT
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
		},
		{
			name = "Launch with arguments (CodeLLDB)",
			type = "codelldb",
			request = "launch",
			program = function(dap)
				local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return (path and path ~= "") and path or dap.ABORT
			end,
			args = function(_)
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
}
