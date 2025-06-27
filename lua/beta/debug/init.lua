--[ Overall idea -- TODO: Redo completely the debugging config
--
--	1. Make it hold all language config's in variable like config's and then set up
--	nvim autocmd on file open or file creation to enable config for opened file type
--	based on file extension.
--
--	2. Also make keymap variables in the config table like run-1, run-2, run-3, check-log
--	etc... Then make it assign keymaps to nvim in keymaps.lua file via that table. (Pass
--	slice of config table consisting of keymaps to the keymap.lua file via require() call)
--
--	3. Move language specific plugin here and use event and ft lazy properties to make it
--	work only when that plugin is enabled, also try to make your event like enabling debugger
--	to trigger it only when debugger is working
--
--	4. Use nvim-dap-view instead of nvim-dap-ui for debugging ui
--]
return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {
				winbar = {
					controls = {
						enabled = true,
						position = "right",
						buttons = {
							"play",
							"step_into",
							"step_over",
							"step_out",
							"step_back",
							"run_last",
							"terminate",
							"disconnect",
						},
						custom_buttons = {},
						icons = {
							pause = "",
							play = "",
							step_into = "",
							step_over = "",
							step_out = "",
							step_back = "",
							run_last = "",
							terminate = "",
							disconnect = "",
						},
					},
				},
			},
		},
		{

			"theHamsta/nvim-dap-virtual-text",
			opts = {
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				filter_references_pattern = '<module',
				virt_text_pos = 'eol',
				all_frames = false,
				virt_lines = false,
				virt_text_win_col = nil
			},
			config = function(_, opts)
				require("nvim-dap-virtual-text").setup(opts);
			end,
		},
	},
	config = function()
		local dap = require("dap");

		dap.defaults.fallback.terminal_win_cmd = '20split new'


		local configs = require("wasabi.langs").get_config_files("debug");
		for lang_name, lang_config in pairs(configs) do
			if not (lang_config.setup and type(lang_config.setup) == "function") then
				vim.notify( -- TODO: change to one simple notify foo for everything
					"failed to setup debuginh for " .. lang_name,
					vim.log.levels.ERROR
				)
			else
				for _, type in ipairs(lang_config.extensions) do
					if type == vim.bo.filetype then -- FIXME: fails if new file opened or if nvim starts with startup screen
						local ok, err = pcall(lang_config.setup, dap);
						if not ok then
							vim.notify( -- TODO: change to one simple notify foo for everything
								"failed to setup debuginh for " .. lang_name .. ": " .. tostring(err),
								vim.log.levels.ERROR
							)
						end
					end
				end
			end
		end

		require("wasabi.keymaps").dap(dap, require("dap-view"));
	end
}
