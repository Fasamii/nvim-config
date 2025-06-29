local M = {}

M.filetypes = { "java" }
M.extensions = { "java" }

-- Dependencies specific to Java debugging
M.dependencies = {
    {
        "microsoft/java-debug",
        build = "./mvnw clean compile",
        version = "0.*",
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            -- Basic JDTLS setup will be handled by the user's LSP configuration
            -- This is just for DAP integration
        end,
    }
}

-- Setup function called by the main debug config
function M.setup(dap)
    -- Check if Java is available
    if vim.fn.executable("java") == 0 then
        vim.notify("Java not found. Please install Java JDK.", vim.log.levels.WARN)
        return
    end
    
    -- Java Debug adapter
    local java_debug_path = vim.fn.stdpath("data") .. "/lazy/java-debug"
    local java_debug_jar = java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    
    -- Find the actual jar file
    local jar_files = vim.fn.glob(java_debug_jar, false, true)
    local debug_jar = jar_files[1]
    
    if debug_jar and vim.fn.filereadable(debug_jar) == 1 then
        dap.adapters.java = function(callback, config)
            local port = config.port or 5005
            
            -- Start the debug adapter
            callback({
                type = 'server',
                host = config.host or '127.0.0.1',
                port = port,
            })
        end
    else
        vim.notify("Java Debug jar not found. Please run :Lazy build java-debug", vim.log.levels.WARN)
        return
    end
    
    -- Java configurations
    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = "Attach to remote JVM",
            hostName = function()
                return vim.fn.input("Host: ", "127.0.0.1")
            end,
            port = function()
                return tonumber(vim.fn.input("Port: ", "5005"))
            end,
        },
        {
            type = 'java',
            request = 'launch',
            name = "Launch Java Application",
            mainClass = function()
                return vim.fn.input("Main class: ", "")
            end,
            projectName = function()
                local cwd = vim.fn.getcwd()
                return vim.fn.fnamemodify(cwd, ":t")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return args_string ~= "" and vim.split(args_string, " ") or {}
            end,
            vmArgs = function()
                local vm_args = vim.fn.input("VM arguments: ")
                return vm_args ~= "" and vim.split(vm_args, " ") or {}
            end,
        },
        {
            type = 'java',
            request = 'launch',
            name = "Launch current file",
            mainClass = function()
                local file = vim.fn.expand('%:t:r')
                local package = vim.fn.system("grep -m1 '^package' " .. vim.fn.expand('%:p') .. " | sed 's/package //;s/;//'"):gsub('%s+', '')
                if package ~= "" then
                    return package .. "." .. file
                else
                    return file
                end
            end,
            projectName = function()
                local cwd = vim.fn.getcwd()
                return vim.fn.fnamemodify(cwd, ":t")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
        {
            type = 'java',
            request = 'launch',
            name = "Debug JUnit test",
            mainClass = "org.junit.platform.console.ConsoleLauncher",
            args = {
                "--select-class",
                function()
                    local file = vim.fn.expand('%:t:r')
                    local package = vim.fn.system("grep -m1 '^package' " .. vim.fn.expand('%:p') .. " | sed 's/package //;s/;//'"):gsub('%s+', '')
                    if package ~= "" then
                        return package .. "." .. file
                    else
                        return file
                    end
                end,
            },
            projectName = function()
                local cwd = vim.fn.getcwd()
                return vim.fn.fnamemodify(cwd, ":t")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
        {
            type = 'java',
            request = 'launch',
            name = "Debug Spring Boot",
            mainClass = function()
                return vim.fn.input("Spring Boot main class: ", "")
            end,
            projectName = function()
                local cwd = vim.fn.getcwd()
                return vim.fn.fnamemodify(cwd, ":t")
            end,
            cwd = "${workspaceFolder}",
            env = {
                SPRING_PROFILES_ACTIVE = "debug"
            },
            vmArgs = {
                "-Dspring.profiles.active=debug"
            },
            stopOnEntry = false,
        },
    }
    
    -- Java-specific keymaps
    vim.keymap.set('n', '<leader>dj', function()
        -- Try to compile with javac
        local file = vim.fn.expand('%:p')
        local class_name = vim.fn.expand('%:t:r')
        local cmd = 'javac -g -cp ".:*" ' .. file
        
        vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
            vim.
