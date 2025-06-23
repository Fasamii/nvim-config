return {
	"echasnovski/mini.trailspace",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- TODO: make global notify foo and require it here
		local notify = function(msg, ll)
			local ok, fidget = pcall(require, "fidget");
			if ok then
				fidget.notify(msg, ll);
			else
				vim.notify(msg, ll);
			end
		end

		-- TODO: make json or some other format file to store toggle settings like auto_trail_space
		local cmd_id = nil;
		local cmd_enabled = false;
		local function _has_lsp_attached()
			-- Neovim ≥0.8: use vim.lsp.get_active_clients()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			return next(clients) ~= nil
		end

		local function create_cmd()
			cmd_id = vim.api.nvim_create_autocmd("CursorMoved", {
				pattern = "*",
				callback = function()
					if _has_lsp_attached() then
						require("mini.trailspace").trim();
					end
				end
			});
		end

		local function toggle_cmd()
			if cmd_enabled then
				if cmd_id then
					vim.api.nvim_del_autocmd(cmd_id);
					cmd_id = nil;
				end
				cmd_enabled = false;
				notify("Auto-trim Disabled", vim.log.levels.INFO);
			else
				create_cmd();
				cmd_enabled = true;
				notify("Auto-trim Enabled", vim.log.levels.INFO);
			end
		end

		if cmd_enabled then create_cmd() end;
		require("wasabi.keymaps").trailspace(toggle_cmd);
	end
}
