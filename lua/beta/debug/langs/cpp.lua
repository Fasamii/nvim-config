local M = {}

M.filetypes = { "cpp", "cxx", "cc" }
M.extensions = { "cpp", "cxx", "cc", "hpp", "hxx", "hh" }

-- Dependencies specific to C++ debugging
M.dependencies = {}

-- Setup function called by the main debug config
function M.setup(dap)
    -- Check if gdb is available
    if vim.fn.executable("gdb") == 0 then
        vim.notify("GDB not found. Please install GDB for C++ debugging.", vim.log.levels.WARN)
        return
    end
    
    -- C++ adapter configuration using GDB (if not already configured by C)
    if not dap.adapters.gdb then
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "-i", "dap" }
        }
    end
    
    -- Alternative: codelldb adapter (if available and not already configured)
    if not dap.adapters.codelldb then
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                command = vim.fn.exepath("codelldb") or "codelldb",
                args = {"--port", "${port}"},
            }
        }
    end
    
    -- C++ configurations
    dap.configurations.cpp = {
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
    
    -- Copy configurations for other C++ filetypes
    dap.configurations.cxx = dap.configurations.cpp
    dap.configurations.cc = dap.configurations.cpp
    
    -- Auto-compile keymaps for C++
    vim.keymap.set('n', '<leader>dC', function()
        local file = vim.fn.expand('%:p')
        local output = vim.fn.expand('%:p:r')
        local cmd = string.format('g++ -g -std=c++17 -o %s %s', output, file)
        
        vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
            vim.notify("Compiled successfully: " .. output, vim.log.levels.INFO)
        else
            vim.notify("Compilation failed!", vim.log.levels.ERROR)
        end
    end, { desc = 'Debug: Compile C++ file' })
    
    -- CMake build and debug
    vim.keymap.set('n', '<leader>dM', function()
        local build_dir = vim.fn.input('Build directory: ', 'build/')
        if build_dir ~= '' then
            vim.fn.system('cmake --build ' .. build_dir)
            if vim.v.shell_error == 0 then
                vim.notify("CMake build successful", vim.log.levels.INFO)
            else
                vim.notify("CMake build failed!", vim.log.levels.ERROR)
            end
        end
    end, { desc = 'Debug: CMake build' })
end

return M
