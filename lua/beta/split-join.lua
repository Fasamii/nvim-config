return {
	"echasnovski/mini.splitjoin",
	opts = {
		mappings = {
			join = "",
			split = "",
			toggle = "",
		},
	},
	config = function(_, opts)
		local sj = require("mini.splitjoin");
		sj.setup(opts);
		require("wasabi.keymaps").splitjoin(sj);
	end
}
