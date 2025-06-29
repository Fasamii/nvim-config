local M = {}

M.filetypes = { "rust" }
M.extensions = { "rs" }

-- Dependencies specific to Rust debugging
M.dependencies = {
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = { "rust" },
        config = function()
            vim.g.rustaceanvim = {
                dap = {
                    adapter = {
                        type = "executable",
                        command = "lldb-vscode",
                        name = "rt_lldb",
                    },
                },
            }
        end,
    }
}

-- Setup function called by the main debug config
function M.setup(dap)
    -- Check if rust and cargo are available
    if vim.fn.executable("cargo") == 0 then
        vim.notify("Cargo not found. Please install Rust toolchain.", vim.log.levels.WARN)
        return
    end
    
    -- CodeLLDB adapter for Rust
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            command = vim.fn.exepath("codelldb") or "codelldb",
            args = {"--port", "${port}"},
        }
    }
    
    -- Alternative: lldb-vscode adapter
    dap.adapters.lldb = {
        type = 'executable',
        command = vim.fn.exepath("lldb-vscode") or "lldb-vscode",
        name = 'lldb'
    }
    
    -- Rust configurations
    dap.configurations.rust = {
        {
            name = "Launch (Cargo)",
            type = "codelldb",
            request = "launch",
            program = function()
                -- Try to find the target executable
                local metadata = vim.fn.system("cargo metadata --no-deps --format-version 1")
                local ok, parsed = pcall(vim.json.decode, metadata)
                
                if ok and parsed.target_directory then
                    local target_dir = parsed.target_directory
                    local package_name = parsed.packages[1] and parsed.packages[1].name
                    if package_name then
                        local debug_path = target_dir .. "/debug/" .. package_name
                        if vim.fn.filereadable(debug_path) == 1 then
                            return debug_path
                        end
                    end
                end
                
                -- Fallback to manual input
                local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                return (path and path ~= "") and path or dap.ABORT
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        },
        {
            name = "Launch with arguments (Cargo)",
            type = "codelldb",
            request = "launch",
            program = function()
                local metadata = vim.fn.system("cargo metadata --no-deps --format-version 1")
                local ok, parsed = pcall(vim.json.decode, metadata)
                
                if ok and parsed.target_directory then
                    local target_dir = parsed.target_directory
                    local package_name = parsed.packages[1] and parsed.packages[1].name
                    if package_name then
                        local debug_path = target_dir .. "/debug/" .. package_name
                        if vim.fn.filereadable(debug_path) == 1 then
                            return debug_path
                        end
                    end
                end
                
                local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                return (path and path ~= "") and path or dap.ABORT
            end,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " ")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            runInTerminal = false,
        },
        {
            name = "Launch binary",
            type = "codelldb",
            request = "launch",
            program = function()
                local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                return (path and path ~= "") and path or dap.ABORT
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        },
        {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        -- Using LLDB adapter
        {
            name = "Launch (LLDB)",
            type = "lldb",
            request = "launch",
            program = function()
                local path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                return (path and path ~= "") and path or dap.ABORT
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }
    
    -- Rust-specific keymaps
    vim.keymap.set('n', '<leader>dr', function()
        vim.fn.system('cargo build')
        if vim.v.shell_error == 0 then
            vim.notify("Cargo build successful", vim.log.levels.INFO)
        else
            vim.notify("Cargo build failed!", vim.log.levels.ERROR)
        end
    end, { desc = 'Debug: Cargo build' })
    
    vim.keymap.set('n', '<leader>dR', function()
        vim.fn.system('cargo build --release')
        if vim.v.shell_error == 0 then
            vim.notify("Cargo release build successful", vim.log.levels.INFO)
        else
            vim.notify("Cargo release build failed!", vim.log.levels.ERROR)
        end
    end, { desc = 'Debug: Cargo build release' })
    
    vim.keymap.set('n', '<leader>dt', function()
        -- Use rustaceanvim's test debugging if available
        if vim.g.rustaceanvim then
            vim.cmd("RustLsp testables")
        else
            vim.fn.system('cargo test')
        end
    end, { desc = 'Debug: Run Rust tests' })
end

return M
