local M = {}

M.filetypes = { "php" }
M.extensions = { "php", "phtml", "php3", "php4", "php5", "php7", "phps", "php-s" }

-- Dependencies specific to PHP debugging
M.dependencies = {
    {
        "xdebug/vscode-php-debug",
        build = "npm install && npm run build",
        version = "1.*",
    }
}

-- Setup function called by the main debug config
function M.setup(dap)
    -- Check if PHP is available
    if vim.fn.executable("php") == 0 then
        vim.notify("PHP not found. Please install PHP.", vim.log.levels.WARN)
        return
    end
    
    -- PHP Debug adapter
    local php_debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-php-debug"
    
    if vim.fn.isdirectory(php_debug_path) == 1 then
        dap.adapters.php = {
            type = "executable",
            command = "node",
            args = { php_debug_path .. "/out/phpDebug.js" }
        }
    else
        -- Fallback configuration
        dap.adapters.php = {
            type = "executable",
            command = "php-debug-adapter",
        }
    end
    
    -- PHP configurations
    dap.configurations.php = {
        {
            name = "Listen for Xdebug",
            type = "php",
            request = "launch",
            port = 9003,  -- Default Xdebug 3 port
            stopOnEntry = false,
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}",
            },
        },
        {
            name = "Listen for Xdebug (legacy port)",
            type = "php",
            request = "launch",
            port = 9000,  -- Legacy Xdebug 2 port
            stopOnEntry = false,
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}",
            },
        },
        {
            name = "Launch currently open script",
            type = "php",
            request = "launch",
            program = "${file}",
            cwd = "${fileDirname}",
            port = 0,
            runtimeArgs = {
                "-dxdebug.start_with_request=yes"
            },
            env = {
                XDEBUG_MODE = "debug,develop",
                XDEBUG_CONFIG = "client_port=${port}"
            }
        },
        {
            name = "Launch script with arguments",
            type = "php",
            request = "launch",
            program = "${file}",
            cwd = "${fileDirname}",
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " ")
            end,
            port = 0,
            runtimeArgs = {
                "-dxdebug.start_with_request=yes"
            },
            env = {
                XDEBUG_MODE = "debug,develop",
                XDEBUG_CONFIG = "client_port=${port}"
            }
        },
        {
            name = "Launch with custom path mappings",
            type = "php",
            request = "launch",
            port = 9003,
            stopOnEntry = false,
            pathMappings = function()
                local remote_path = vim.fn.input("Remote path: ", "/var/www/html")
                local local_path = vim.fn.input("Local path: ", "${workspaceFolder}")
                local mappings = {}
                mappings[remote_path] = local_path
                return mappings
            end,
        },
        {
            name = "Debug PHPUnit test",
            type = "php",
            request = "launch",
            program = function()
                local phpunit_path = vim.fn.input("PHPUnit path: ", "vendor/bin/phpunit")
                return phpunit_path
            end,
            args = function()
                local test_file = vim.fn.input("Test file: ", "${file}")
                return { test_file }
            end,
            cwd = "${workspaceFolder}",
            port = 0,
            runtimeArgs = {
                "-dxdebug.start_with_request=yes"
            },
            env = {
                XDEBUG_MODE = "debug,develop",
                XDEBUG_CONFIG = "client_port=${port}"
            }
        },
    }
    
    -- PHP-specific keymaps and utilities
    vim.keymap.set('n', '<leader>dp', function()
        -- Check if Xdebug is enabled
        local output = vim.fn.system('php -m | grep -i xdebug')
        if output ~= '' then
            vim.notify("Xdebug is enabled", vim.log.levels.INFO)
        else
            vim.notify("Xdebug is NOT enabled. Please install and enable Xdebug extension.", vim.log.levels.WARN)
        end
    end, { desc = 'Debug: Check Xdebug status' })
    
    vim.keymap.set('n', '<leader>dP', function()
        local file = vim.fn.expand('%:p')
        local cmd = 'php -l ' .. file
        local output = vim.fn.system(cmd)
        
        if vim.v.shell_error == 0 then
            vim.notify("PHP syntax check passed", vim.log.levels.INFO)
        else
            vim.notify("PHP syntax error: " .. output, vim.log.levels.ERROR)
        end
    end, { desc = 'Debug: PHP syntax check' })
    
    -- Helper function to create php.ini snippet for Xdebug
    vim.keymap.set('n', '<leader>dx', function()
        local config = [[
; Xdebug 3 configuration
zend_extension=xdebug
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_port=9003
xdebug.client_host=127.0.0.1
xdebug.discover_client_host=true
xdebug.idekey=VSCODE
]]
        vim.fn.setreg('+', config)
        vim.notify("Xdebug configuration copied to clipboard", vim.log.levels.INFO)
    end, { desc = 'Debug: Copy Xdebug config to clipboard' })
end

return M
