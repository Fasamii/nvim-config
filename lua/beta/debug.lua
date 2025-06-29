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
			--[
			-- foo's you should use:
			--	.add_expr() -- idk what this do read the docs.
			--	.jump_to_view() -- to add keymaps for switching panels while not being focused on them
			--		& also jumps to it
			--	.show_view() -- shows selected view and does not jump to it
			--	avalibe views are "exceptions" | "watches" | "repl" | "threads" | "console" | "scopes"
			--
			--]
			-- TODO: Configure this plugins
			"igorlfs/nvim-dap-view",
			opts = {
				winbar = {
					show = true,
					sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
					default_section = "watches",
					headers = { -- TODO: use some nicer and more consistent icons
						breakpoints = " Breakpoints [B]",
						scopes = "󱐕 Scopes [S]",
						exceptions = "󱀭 Exceptions [E]",
						watches = "⌚Watches [W]",
						threads = "🧵Threads [T]",
						repl = "󰯂 REPL [R]",
						console = "󰆍 Console [C]",
					},
					controls = {
						enabled = true,
						position = "left",
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
						-- TODO: thin of usage for that
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
				windows = {
					height = 12,
					position = "below",
					terminal = {
						position     = "left",
						width        = 0.5,
						-- List of debug adapters for which the terminal should be ALWAYS hidden
						hide         = {},
						start_hidden = false,
					},
				},
				switchbuf = "usetab,newtab",
			},
			config = function(_, opts)
				local dap, dabview = require("dap"), require("dap-view");
				dabview.setup(opts);
				dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab" -- NOTE: some fix listed in docs
				dap.listeners.before.attach["dap-view-config"] = function()
					dabview.open()
				end
				dap.listeners.before.launch["dap-view-config"] = function()
					dabview.open()
				end
				dap.listeners.before.event_terminated["dap-view-config"] = function()
					dabview.close()
				end
				dap.listeners.before.event_exited["dap-view-config"] = function()
					dabview.close()
				end

				-- TODO: move that to wasabi/keymaps.lua file
				vim.api.nvim_create_autocmd({ "FileType" }, {
					pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
					callback = function(evt)
						vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf })
					end,
				})
			end
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

		local files = require("wasabi.langs").get_config_files("debug");
		for name, configs in pairs(files) do
		end

		require("wasabi.keymaps").dap(dap, require("dap-view"));
	end
}
