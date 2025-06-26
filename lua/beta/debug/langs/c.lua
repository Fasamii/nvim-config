--[ Overall structure --TODO: make it that way
-- {
--	extensions = { "c", "h" },
--
--	dependencies = {
--		{
--			-- Plugin config's --
--		},
--		{
--			-- Plugin config's --
--		},
--	},
--
--	adapters = {
--		gdb = {
--			type = "executable",
--			command = "gdb",
--			args = { "-i", "dap" },
--		},
--		codelldb = {
--			...,
--		},
--	},
--
--	configurations = {
--		c = { -- TODO: consider automatically inserting <lang name> between configuration's and actual
--			-- configurations. Based on file name.
--			...,
--		},
--	},
--
--	keymaps = {
--		run-1 = function()
--			...;
--		end
--	}
-- }
--]
local M = {}

M.filetypes = { "c" }
M.extensions = { "c", "h" }

-- Dependencies specific to C debugging
M.dependencies = {}

-- Setup function called by the main debug config
function M.setup(dap)
	-- Check if gdb is available 
	-- TODO: move that to the init.lua file
	if vim.fn.executable("gdb") == 0 then
		vim.notify("GDB not found. Please install GDB for C debugging.", vim.log.levels.WARN)
		return
	end

	-- C adapter configuration using GDB
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "-i", "dap" }
	}

	-- Alternative: codelldb adapter (if available)
	dap.adapters.codelldb = {
		type = 'server',
		port = "${port}",
		executable = {
			command = vim.fn.exepath("codelldb") or "codelldb",
			args = { "--port", "${port}" },
		}
	}

	-- C configurations
	dap.configurations.c = {
		{
			name = "Launch (GDB)",
			type = "gdb",
			request = "launch",
			program = function()
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
			program = function()
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
			program = function()
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
			program = function()
				local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return (path and path ~= "") and path or dap.ABORT
			end,
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " ")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}

	-- Auto-compile keymaps for C
	vim.keymap.set('n', '<leader>dc', function()
		local file = vim.fn.expand('%:p')
		local output = vim.fn.expand('%:p:r')
		local cmd = string.format('gcc -g -o %s %s', output, file)

		vim.fn.system(cmd)
		if vim.v.shell_error == 0 then
			vim.notify("Compiled successfully: " .. output, vim.log.levels.INFO)
		else
			vim.notify("Compilation failed!", vim.log.levels.ERROR)
		end
	end, { desc = 'Debug: Compile C file' })
end

return M
