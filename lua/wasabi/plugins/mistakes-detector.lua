return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		disable_mouse = false,
		restriction_mode = "hint",
		timeout = 3000,
		callback = function(msg)
			local ok, fidget = pcall(require, "fidget");
			if ok then
				fidget.notify(msg, vim.log.levels.ERROR);
			else
				local buf = vim.api.nvim_create_buf(false, true);
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg });

				local width = string.len(msg);
				local height = 1;
				local opts = {
					relative = 'editor',
					width = width,
					height = height,
					col = vim.o.columns - width,
					row = vim.o.lines - height - 3,
					style = "minimal",
					border = "solid"
				};

				local win = vim.api.nvim_open_win(buf, false, opts);

				-- Auto-close after 3 seconds
				vim.defer_fn(function()
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_close(win, true);
					end;
				end, 3000);
			end;
		end,
		-- -- Disabling hints
		--
		-- disabled_keys = {
		-- 	["<Up>"] = false, -- Allow <Up> key
		-- 	["<Space>"] = { "n", "x" }, -- Disable <Space> key in normal and visual mode
		-- },
		-- disabled_filetypes = {
		-- 	lazy = false, -- Enable Hardtime in lazy filetype
		-- 	["dapui*"] = false, -- Enable Hardtime in filetype starting with dapui
		-- },
		--
		-- -- Making custom hints
		--
		-- hints = {
		-- 	["k%^"] = {
		-- 		message = function()
		-- 			return "Use - instead of k^" -- return the hint message you want to display
		-- 		end,
		-- 		length = 2,   -- the length of actual key strokes that matches this pattern
		-- 	},
		-- 	["d[tTfF].i"] = {   -- this matches d + {t/T/f/F} + {any character} + i
		-- 		message = function(keys) -- keys is a string of key strokes that matches the pattern
		-- 			return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
		-- 			-- example: Use ct( instead of dt(i
		-- 		end,
		-- 		length = 4,
		-- 	},
		-- }
	},
}
